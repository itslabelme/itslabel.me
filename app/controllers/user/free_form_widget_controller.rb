module User
  class FreeFormWidgetController < User::BaseController

    before_action :authenticate_client_user!
    skip_before_action :verify_authenticity_token
    before_action :get_languages

    def index

      @page_title = "Free Form Translation"
      @nav = 'user/free_form'
    end

    def translate

      @input_text = params[:text].strip
      @translated_hash = Translation.translate(@input_text, input_language: @input_language, output_language: @output_language, return_in_hash: true)
      
      @display_text = ""
      tokens = @translated_hash["_tokens"]

      tokens.each do |tk|

        # tk.strip gives "" if tk == "\n" or those characters
        # hence handling them separately
        if tk.match(/;|\(|\)|\[|\]|:|\||!|\-|\t|\r|\n/)
          translated_text = @translated_hash[tk]
        else
          if tk.strip.blank?
            translated_text = tk
          else
            translated_text = @translated_hash[tk.strip]
          end
        end
        
        if translated_text
          @display_text += translated_text + " "
        else
          dir_attr = @output_language == "ARABIC" ? 'rtl' : ''
          @display_text += "<span class='its-tran-not-found' dir='#{dir_attr}'><i class=\"icon-question mr-2\"></i>#{tk}</span>"
        end
      end

      @display_text.gsub!(/\n+/, '<br>')
      
    end

    def new_translation_request
    end

    def create_translation_request
      @success = true
      TranslationRequestMailerJob.perform_later(
        params[:phrase], 
        @current_client_user, 
        params[:input_language], 
        params[:output_language]
      )
    end

    private

    def get_languages
      @input_language = params[:input_language].to_s.strip unless params[:input_language].to_s.strip.blank?
      @output_language = params[:output_language].to_s.strip unless params[:output_language].to_s.strip.blank?

      @input_language = "ENGLISH" unless @input_language
      @output_language = "ARABIC" unless @output_language
    end


  end
end