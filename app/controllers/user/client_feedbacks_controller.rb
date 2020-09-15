module User
  class ClientFeedbacksController < User::BaseController
    before_action :authenticate_client_user!
    before_action :get_user_subscription
  
    def index
      @page_title = "Client Feedback"
      @nav = 'user/client feedbacks'
    end
    
    def new
      @feedback=ClientsFeedback.new
    end

    def create
      @feedback=ClientsFeedback.new(feedback_params)
      if @feedback.save
        redirect_to @feedback
      else
        render 'new'
      end
    end

   private

   def feedback_params
        params.require(:clients_feedbacks).permit(@current_client_user, :input, :output, :remarks)
   end
  
  end
end