module User
  class ClentFeedbacksController < User::BaseController
    before_action :authenticate_client_user!
    before_action :get_user_subscription
  
    def index
      @page_title = "Free Form Translation"
      @nav = 'user/free form'
    end
    
    def new
      @feedback=ClientsFeedback.new
    end

    def create
      @feedback=ClientsFeedback.new(feedback_params)
      @feedback.save
    end

    private

   def feedback_params
        params.require(:clients_feedbacks).permit(@current_client_user, :input, :output, :remarks)
   end
   end
end