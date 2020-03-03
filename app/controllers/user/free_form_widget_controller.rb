module User
  class FreeFormWidgetController < User::BaseController

    before_action :authenticate_client_user!
    skip_before_action :verify_authenticity_token
    before_action :get_languages
    before_action :access_denied
    def index

      @page_title = "Free Form Translation"
      @nav = 'user/free_form'
    end

    def translate

      @input_text = params[:text].strip
      @translated_hash = Translation.translate(@input_text, input_language: @input_language, output_language: @output_language, return_in_hash: true)
      @display_text = @input_text
      @translated_hash.each do |key, value|
        if value
          @display_text.gsub!(key, value)
        else
          @display_text.gsub!(key, "<span class='its-tran-not-found'><i class=\"icon-question mr-2\"></i>#{key}</span>")
        end
      end

      delimitters = @input_text.scan(Regexp.union(Translation::DELIMITERS))

      delimitters.each do |dlmtr|
        dlmtr_translations = Translation::DELIMITERS_TRANSLATIONS[dlmtr.to_sym]
        translated_dlmtr = dlmtr_translations.try(:[], @output_language.upcase.to_sym)
        @display_text.gsub!(dlmtr, translated_dlmtr) if translated_dlmtr
      end

      @display_text.gsub!("\n", '<br>')
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
