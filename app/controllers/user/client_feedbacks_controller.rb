module User
  class ClientFeedbacksController < User::BaseController
    before_action :authenticate_client_user!
  
    def index
      @page_title = "Client Feedback"
      @nav = 'user/client feedbacks'
    end
    def new
      @feedback=ClientFeedback.new
    end

    def create
      @feedback=ClientFeedback.new(feedback_params)
       @feedback.save   
    end

   private

   def feedback_params
    @type="free_form"
    params.require(:client_feedback).permit( @current_client_user.id, @type, :input, :output, :remarks)
   end
  
  end
end