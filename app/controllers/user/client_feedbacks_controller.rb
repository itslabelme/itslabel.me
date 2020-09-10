module User
  class ClentFeedbacksController < User::BaseController
    before_action :authenticate_client_user!
    before_action :get_user_subscription
  
    def index
      @page_title = "Free Form Translation"
      @nav = 'user/free_form'
    end

    def new
      @input_language = params[:input_language].to_s.strip unless params[:input_language].to_s.strip.blank?
      @output_language = params[:output_language].to_s.strip unless params[:output_language].to_s.strip.blank?

      @input_language = "ENGLISH" unless @input_language
      @output_language = "ARABIC" unless @output_language
      @feedback=ClientsFeedback.new(name:@current_client_user,type:"Free form",input:"hkh",output:"kjk",remarks:"ggg")
      @feedback.save

    end
   end
end