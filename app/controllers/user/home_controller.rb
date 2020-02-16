module User
  class HomeController < User::BaseController

    before_action :authenticate_client_user!
    skip_before_action :verify_authenticity_token
    before_action :get_languages

    def index

      @page_title = "Home | User"
      @nav = 'user/home'
      
    end

    def try

      @input_text = params[:text].strip
      @translated_hash = Translation.translate(@input_text, input_language: @input_language, output_language: @output_language, return_in_hash: true)
      @display_text = @input_text
      @translated_hash.each do |key, value|
        if value
          @display_text.gsub!(key, value)
        else
          @display_text.gsub!(key, "<span class='not-found'>#{key}</span>")
        end
      end
      @display_text.gsub!("\n", '<br>')
      
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
