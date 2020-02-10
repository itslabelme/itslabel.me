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

      @translated_text = Translation.translate(params[:text], 
                            input_language: @input_language, 
                            output_language: @output_language)
      
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
