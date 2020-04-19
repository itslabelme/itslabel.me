module User
  class FreeFormWidgetController < User::BaseController

    before_action :authenticate_client_user!
    skip_before_action :verify_authenticity_token
    before_action :get_languages

    # FIXME
    # before_action :access_denied

    def index

      @page_title = "Free Form Translation"
      @nav = 'user/free_form'
    end

    def translate

      @input_text = params[:text]
        
      if @input_language == @output_language
        @display_text = @input_text
      else
        @translated_html = Translation.translate_html(@input_text, input_language: @input_language, output_language: @output_language, return_in_hash: true)
        @display_text = @translated_html.to_html
      end
      
    end

    def export_free_translation

      @input_text = params[:text]
        
      if @input_language == @output_language
        @display_text = @input_text
      else
        @translated_html = Translation.translate_html(@input_text, input_language: @input_language, output_language: @output_language, return_in_hash: true)
        @display_text = @translated_html.to_html
      end

      respond_to do |format|
        format.html
        format.pdf do
          render  :pdf => 'file_name',
                  :template => '/user/free_form_widget/export_free_translation.pdf.erb',
                  :layout => 'pdf.html.erb'
                  #:show_as_html => params[:debug].present?
        end
      end
      
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