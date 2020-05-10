module User
 class UserSubscriptionsController < User::BaseController
  before_action :authenticate_client_user!
  before_action :get_user_subscription
  before_action :access_denied, only: [:index, :new]
  def index
   get_permissions
   @subscriptions=Subscription.all
   if !@user_subscription.blank?
    get_user_subscription
   else
    new_user_subscription
   end
  end
    
  def create
   new_user_subscription
    
   @user_subscription.assign_attributes(user_subscription_params)
     
   if @user_subscription.valid?
    @user_subscription.save
    set_notification(true, I18n.t('status.success'), I18n.t('success.created', item: "Subscription"))
    set_flash_message(I18n.translate("success.created", item: "Subscription"), :success)
   else
    @per_page=params[:page]
    message = I18n.t('errors.failed_to_create', item: "subscription")
    @user_subscription.errors.add :base, message
    set_notification(false, I18n.t('status.error'), message)
    set_flash_message('The form has some errors. Please correct them and submit again', :error)
   end
  end
    
  def edit
      
  end
    
  def update
   @user_subscription.assign_attributes(user_subscription_params)
     
   if @user_subscription.valid?
    @user_subscription.save
    set_notification(true, I18n.t('status.success'), I18n.t('success.updated', item: "Subscription"))
    set_flash_message(I18n.translate("success.updated", item: "Subscription"), :success)
   else
    @per_page=params[:page]
    message = I18n.t('errors.failed_to_create', item: "subscription")
    @user_subscription.errors.add :base, message
    set_notification(false, I18n.t('status.error'), message)
    set_flash_message('The form has some errors. Please correct them and submit again', :error)
   end
  end
  def destroy
      
  end
    
  private
    
  def get_user_subscription
   @user_subscription = UserSubscription.find_by(user_id:current_client_user)
  end
  def new_user_subscription
   @user_subscription = UserSubscription.new
  end
  def user_subscription_params
   params.require(:user_subscription).permit(
    :id,
    :user_id,
    :subscription_id
   )
  end
    
  def get_permissions
   @permissions=Permission.all
  end

 end
end