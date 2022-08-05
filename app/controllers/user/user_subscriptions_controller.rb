module User
  class UserSubscriptionsController < User::BaseController
    before_action :authenticate_client_user!, except: [:api_downgrade]
    before_action :get_user_subscription
    #before_action :access_denied, only: [:index, :new]
    
    def index
      get_permissions
      @subscriptions=Subscription.all
      # binding.pry
      if !@user_subscription.blank?
     
        get_user_subscription
        # raise @user_subscription.subscription_id.inspect
      else
        new_user_subscription
        # @user_subscription.subscription_id=1   // changed by sanoop to fix susbcription time issue
        sub_id = Subscription.find_by_title("Free")
        @user_subscription.subscription_id= sub_id.id
      end
    end
    
    def create
      new_user_subscription
    
      @user_subscription.assign_attributes(user_subscription_params)
     
      if @user_subscription.valid?
        @user_subscription.save
        set_notification(true, I18n.t('status.success'), I18n.t('success.created', item: "Subscription"))
        set_flash_message(I18n.translate("success.created", item: "Subscription"), :success)
        respond_to do |format|
          format.js { render inline: "location.reload();" }
        end
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
      # @user_subscription.assign_attributes(user_subscription_params)
      assign_user_subscription_params

      @stripe_sub = StripeChargesServices.new(charges_params, current_client_user, params['user_subscription']['sub_id']).susbscribe
      # binding.pry
      if @stripe_sub[:status] == 200
        # if @stripe_sub.status == "active" # In Active mode and sucessfull subscription
        if @stripe_sub[:data].status == "trialing"  # When in trail mode
        # if @stripe_sub[:data].status == "incomplete" # In Test Mode
          @user_subscription.usr_subscr_strip_token = @stripe_sub[:data].id
          

          if @user_subscription.valid?
            @user_subscription.save
            redirect_to user_user_subscriptions_path
            set_notification(true, I18n.t('status.success'), I18n.t('success.updated', item: "Subscription"))
            set_flash_message(I18n.translate("success.updated", item: "Subscription"), :success)
            # respond_to do |format|
            #   format.js { render inline: "location.reload();" }
            # end
          else
            @per_page=params[:page]
            message = I18n.t('errors.failed_to_create', item: "subscription")
            @user_subscription.errors.add :base, message
            set_notification(false, I18n.t('status.error'), message)
            set_flash_message('The form has some errors. Please correct them and submit again', :error)
          end


        else
          set_notification(false, 'The form has some errors. Please correct them and submit again', 'The form has some errors. Please correct them and submit again')
          # message = I18n.t('Issues on Subscription Payment', item: "subscription")
          # @user_subscription.errors.add :base, message
          set_flash_message('The form has some errors. Please correct them and submit again', :error)
          redirect_to controller: :user_subscriptions, action: :index
        end
      else

        get_permissions
        @subscriptions=Subscription.all
        if !@user_subscription.blank?
       
          get_user_subscription
          # raise @user_subscription.subscription_id.inspect
        else
          new_user_subscription
          sub_id = Subscription.find_by_title("Free")
          @user_subscription.subscription_id= sub_id.id
        end
      end
    end

    def downgrade_subscription
      user_id = params['subscription']['user_id']
      sub_id = params['subscription']['sub_id']
      
      GeneralServices.new(user_id, nil).downgrade_plan
      StripeChargesServices.new(charges_params, current_client_user, sub_id).delete_subscription
    end
    
    def subscribe
      # binding.pry

      StripeChargesServices.new(nil, current_client_user, ).susbscribe
    end

    private
    
    def charges_params
      params.permit(:stripeEmail, :stripeToken, :order_id)
    end

    def get_user_subscription
      @user_subscription = UserSubscription.find_by(user_id:current_client_user)
    end

    def assign_user_subscription_params
      @user_subscription.user_id = params["user_subscription"]["user_id"].to_i
      @user_subscription.subscription_id = params["user_subscription"]["sub_id"].to_i
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