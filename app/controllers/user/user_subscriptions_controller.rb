module User
  class UserSubscriptionsController < User::BaseController
    before_action :authenticate_client_user!
    before_action :get_user_subscription
    
    def index
      @subscriptions=Subscription.all
      get_user_subscription
    # puts @user_subscriptions.inspect 
      #snew_user_subscription
    end
    
    def create
      new_user_subscription
     # raise params.inspect 
      @user_subscriptions.assign_attributes(user_subscriptions_params)
     
      if @user_subscriptions.valid?
        @user_subscriptions.save
        set_notification(true, I18n.t('status.success'), I18n.t('success.created', item: "Subscription"))
        set_flash_message(I18n.translate("success.created", item: "Subscription"), :success)
      else
        @per_page=params[:page]
        message = I18n.t('errors.failed_to_create', item: "subscription")
        @user_subscriptions.errors.add :base, message
        set_notification(false, I18n.t('status.error'), message)
        set_flash_message('The form has some errors. Please correct them and submit again', :error)
      end
    end
    
    def edit
      
    end
    
    def update
         @user_subscriptions.assign_attributes(user_subscriptions_params)
     
      if @user_subscriptions.valid?
        @user_subscriptions.save
        set_notification(true, I18n.t('status.success'), I18n.t('success.created', item: "Subscription"))
        set_flash_message(I18n.translate("success.created", item: "Subscription"), :success)
      else
        @per_page=params[:page]
        message = I18n.t('errors.failed_to_create', item: "subscription")
        @user_subscriptions.errors.add :base, message
        set_notification(false, I18n.t('status.error'), message)
        set_flash_message('The form has some errors. Please correct them and submit again', :error)
      end
    end
    def destroy
      
    end
    
    private
    
    def get_user_subscription
      @user_subscriptions = UserSubscription.find_by(user_id:current_client_user)
    end
    def new_user_subscription
      @user_subscriptions = UserSubscription.new
    end
    def user_subscriptions_params
       params.require(:user_subscriptions).permit(
        :id,
        :user_id,
        :subscription_id
        )
    end
  end
end