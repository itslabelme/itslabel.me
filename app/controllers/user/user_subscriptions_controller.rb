module User
  class UserSubscriptionsController < User::BaseController
    before_action :authenticate_client_user!, except: [:api_downgrade]
    before_action :get_user_subscription
    #before_action :access_denied, only: [:index, :new]

    require 'rest-client'
    require 'json'

    def index
      get_permissions
      @subscriptions=Subscription.all
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
    
    def show
    end

    def edit
    end
    
    def update
      refresh_token = Rails.application.secrets.zoho_refresh_token
      parameters = {'refresh_token': refresh_token,
                    'zoho_subscription_id': @user_subscription.zoho_subscription_id,
                    'plan_code':  params['user_subscription']['plan_code'],
                    'plan_description':  params['user_subscription']['plan_description'],
                    'price':  params['user_subscription']['price']
                   }
      free_subscription_data = ZohoSubscription.new(parameters).update_zoho_subscription

      if free_subscription_data[:status]
        redirect_to free_subscription_data[:data]['hostedpage']['url']
      else
        redirect_to :user_user_subscriptions
      end
    end



    def zoho_call_back
      refresh_token = Rails.application.secrets.zoho_refresh_token
      parameters = {'refresh_token': refresh_token,
                    'hostedpage_id': params[:hostedpage_id],
                   }
      subscription_payload = ZohoSubscription.new(parameters).fetch_subscription_hosted_data

      if subscription_payload[:status]
        @plan_status = true
        @plan_name = subscription_payload[:data]['data']['subscription']['plan']['name']
        @plan_price = subscription_payload[:data]['data']['subscription']['plan']['price']

        if @user_subscription['status'] == "Free"
          @user_subscription['status'] = 'LIVE'
        end
          @user_subscription['zoho_plan_code'] = subscription_payload[:data]['data']['subscription']['plan']['plan_code']

          if @user_subscription.valid?
            @user_subscription.save
            set_notification(true, I18n.t('status.success'), I18n.t('success.created', item: "Subscription"))
            set_flash_message(I18n.translate("success.created", item: "Subscription"), :success)
          else
            message = I18n.t('errors.failed_to_create', item: "subscription")
            @user_subscription.errors.add :base, message
            set_notification(false, I18n.t('status.error'), message)
            set_flash_message('The form has some errors. Please correct them and submit again', :error)
          end
      else
          @plan_status = false
          message = I18n.t('errors.failed_to_create', item: "subscription")
          @user_subscription.errors.add :base, message
          set_notification(false, I18n.t('status.error'), message)
          set_flash_message('The form has some errors. Please correct them and submit again', :error)
      end
    end

    def downgrade_subscription
      user_id = params['subscription']['user_id']
      sub_id = params['subscription']['sub_id']
      
      GeneralServices.new(user_id, nil).downgrade_plan
      # StripeChargesServices.new(nil, current_client_user, nil).delete_card  # Delete card after downgrade plan
      # StripeChargesServices.new(charges_params, current_client_user, sub_id).delete_subscription

    end
    
    def subscribe
      StripeChargesServices.new(nil, current_client_user, ).susbscribe
    end

    private
    
    def charges_params
      params.permit(:stripeEmail, :stripeToken, :order_id)
    end

    def get_user_subscription
      @user_subscription = ZohoSubData.find_by('client_user_id=?',current_client_user)
      # @user_subscription = UserSubscription.find_by(user_id:current_client_user)
    end

    def assign_user_subscription_params
      @user_subscription.user_id = params["user_subscription"]["user_id"].to_i
      @user_subscription.subscription_id = params["user_subscription"]["sub_id"].to_i
    end

    def new_user_subscription
      # @user_subscription = ZohoSubData.new
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