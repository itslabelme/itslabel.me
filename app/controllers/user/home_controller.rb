module User
  class HomeController < User::BaseController

    before_action :authenticate_client_user!
    skip_before_action :verify_authenticity_token
    before_action :get_languages
    before_action :access_denied
    before_action :check_subscription_plan, only: [:index]

    def index
      @page_title = "Home | User"
      @nav = 'user/home'
    end

    private

    def get_languages
      @input_language = params[:input_language].to_s.strip unless params[:input_language].to_s.strip.blank?
      @output_language = params[:output_language].to_s.strip unless params[:output_language].to_s.strip.blank?

      @input_language = "ENGLISH" unless @input_language
      @output_language = "ARABIC" unless @output_language
    end

    def check_subscription_plan
      # user_subscription = ZohoSubData.find_by('client_user_id=?',current_client_user)
      user_subscription = UserSubscription.find_by(user_id:current_client_user)
      @trial_period = (Date.today.to_date - current_client_user.created_at.to_date).to_i

      if user_subscription.subscription.title.downcase == "Free".downcase && @trial_period >= 7
        redirect_to controller: :user_subscriptions, action: :index
      end

    end


  end
end
