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
        @translated_html = Translation.translate_html(@input_text, input_language: @input_language, output_language: @output_language)
        
        # Save the translation query for Query/Data Set enhancement
        error_status = @translated_html.to_html.include? "its-tran-not-found"
        doc_type = params['controller'].split('/').last || 'Default'
        output_text = @translated_html
        # save_trans_query( @input_text, @input_language, @output_language, output_text, doc_type, error_status)

        @display_text = @translated_html.to_html
      end
      
    end

    def export_free_translation

      @input_text = params[:text]
        
      if @input_language == @output_language
        @display_text = @input_text
      else
        @translated_html = Translation.translate_html(@input_text, input_language: @input_language, output_language: @output_language, return_in_hash: true)

        # Save the translation query for Query/Data Set enhancement
        error_status = @translated_html.to_html.include? "its-tran-not-found"
        doc_type = params['controller'].split('/').last || 'Default'
        output_text = @translated_html
        # save_trans_query( @input_text, @input_language, @output_language, output_text, doc_type, error_status)

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

    def save_trans_query(input_text, input_language, output_language, output_text, doc_type, error_status)
       translation = TranslationQueryHistory.new(
        input_language: input_language || 'Default', 
        output_language: output_language || 'Default',
        input_phrase: input_text || 'Default', 
        output_phrase: output_text.to_html || 'Default', 
        error: error_status || false,
        error_message: output_text || 'Default',
        client_user: @current_client_user,
        doc_type: doc_type,
        status: "ACTIVE"
      )
      if translation.valid?
        translation.save
      end
    end

    def create_translation_request
        translation_request = TranslationRequest.new(
        requested_by:@current_client_user, 
        input_language: params[:input_language], 
        output_language: params[:output_language],
        input_phrase: params[:phrase], 
        doc_type: "Free Form",
        status: "ACTIVE"
      )
      if translation_request.valid?
        translation_request.save
        set_notification(true, I18n.t('status.success'), I18n.t('success.created',item: "Translation Request"))
      else
        translation_request.errors.add :base, message
        set_notification(false, I18n.t('status.error'), "Failed to save Translation Request Feedback")
      end
  
      @success = true
      # TranslationRequestMailerJob.perform_later(
      #   params[:phrase], 
      #   @current_client_user, 
      #   params[:input_language], 
      #   params[:output_language]
      # )
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