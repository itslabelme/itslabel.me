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
      @client_feedback=ClientFeedback.new(permitted_params)
    if @client_feedback.valid?
      @client_feedback.save
    else
      render 'new'
        
    end   
    end
    def permitted_params
      params.require(:client_feedback).permit(:client_user_id,:input,:output,:remarks)
   end
  end
end