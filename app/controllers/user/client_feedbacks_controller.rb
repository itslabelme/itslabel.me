module User
  class ClientFeedbacksController < User::BaseController
    before_action :authenticate_client_user!
  
    def index
      @page_title = "Client Feedback"
      @nav = 'user/client feedbacks'
    end
    def new
      @client_feedback=ClientFeedback.new
      @input = params[:input]
      @output =params[:output]
      @inputlanguage = params[:inputlanguage]    
      @outputlanguage = params[:outputlanguage]
    end

    def create
     @client_feedback=ClientFeedback.new(permitted_params)
     @client_feedback.client_user_id=@current_client_user.id
     @client_feedback.category="Free-Form"
     if @client_feedback.valid?
      @client_feedback.save
      set_notification(true, I18n.t('status.success'), I18n.t('success.created',item: "Feedback"))
      set_flash_message(I18n.translate("success.created"), :success)
     else
      set_notification(false, I18n.t('status.error'),"Please correct them and submit again")
      set_flash_message('The form has some errors. Please correct them and submit again', :error)
     end   
    end
   
    private
    
    def permitted_params
      params.require(:client_feedback).permit(:client_user_id,:input,:output,:remarks,:category,:input_language,:output_language)
   end
  end
end