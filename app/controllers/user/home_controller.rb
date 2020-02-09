module User
  class HomeController < User::BaseController

    before_action :authenticate_client_user!
    skip_before_action :verify_authenticity_token

    def index

      @page_title = "Home | User"
      @nav = 'user/home'
      
    end

    def try

      input_language = params[:input_language]
      output_language = params[:output_language]
      text = params[:text]
      @translated_text = Translation.translate(text, input_language: input_language, output_language: output_language)
      
    end

  end
end
