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
    
    def show
    end

    def edit
    end
    
    def update
      # @user_subscription.assign_attributes(user_subscription_params)
      assign_user_subscription_params

      @stripe_sub = StripeChargesServices.new(charges_params, current_client_user, params['user_subscription']['sub_id']).susbscribe
      # binding.pry
      Rails.logger.debug( "Stripe status ----- #{@stripe_sub[:status]}")
      if @stripe_sub[:status] == 200
        # if @stripe_sub.status == "active" # In Active mode and sucessfull subscription
        # if @stripe_sub[:data].status == "trialing"  # When in trail mode
        # if @stripe_sub[:data].status == "incomplete" # In Test Mode
        Rails.logger.debug( "Stripe data status ----- #{@stripe_sub[:data].status}")
        if ['incomplete', 'active'].include? @stripe_sub[:data].status # to solve if give active status and incomplete status
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

    def zoho_call_back

      # Examples

        # # GET request with modified headers
        # RestClient.get 'http://example.com/resource', {:Authorization => 'Bearer cT0febFoD5lxAlNAXHo6g'}

        # # POST request with modified headers
        # RestClient.post 'http://example.com/resource', {:foo => 'bar', :baz => 'qux'}, {:Authorization => 'Bearer cT0febFoD5lxAlNAXHo6g'}

        # # DELETE request with modified headers
        # RestClient.delete 'http://example.com/resource', {:Authorization => 'Bearer cT0febFoD5lxAlNAXHo6g'}

        # client_token = 
        # client_id = 
        # code = 
        # access_token = 
        # refresh_token = 
        # parameters = {'client_token': '12', 'client_id': '13', 'code': '14'}
        # ZohoSubscription.new(parameters).get_hostedpages_details


        # hostedpages_id = '2-8a55a069e007bc990b9825803d96bd1418a3f91e7f92be9aae83f416ab6f5de705fca12d11bacc6ccd8887b17b8ad7f2'
        hostedpages_id = params[:hostedpage_id]

        refresh_token = '1000.3b2750d37e26adefc8a6ba67dfc848c8.829e016bac3b60ca9129e8d3a3689177'
        parameters = {'hostedpages_id': hostedpages_id, 'refresh_token': refresh_token}
        hostedpage_pay_loads = ZohoSubscription.new(parameters).get_hostedpages_details

        @plan_name = nil
        @plan_price = nil
        @plan_status = false

        # binding.pry
        if hostedpage_pay_loads
          if hostedpage_pay_loads['status'] = 'success'

            @plan_name = hostedpage_pay_loads['data']['subscription']['plan']['name']
            @plan_price = hostedpage_pay_loads['data']['subscription']['plan']['price']
            @plan_status = true

            @zoho_sub_data = ZohoSubData.new
            @zoho_sub_data.client_user_id = @current_client_user.id

            subscription_plan = hostedpage_pay_loads['data']['subscription']['plan']['plan_code'].gsub(/\s+/, "")
            @zoho_sub_data.subscription = Subscription.find_by_title(subscription_plan) || Subscription.find_by_title("Free")

            @zoho_sub_data.zoho_customer_id = hostedpage_pay_loads['data']['subscription']['customer_id']
            @zoho_sub_data.zoho_subscription_id = hostedpage_pay_loads['data']['subscription']['subscription_id']
            @zoho_sub_data.zoho_plan_code = hostedpage_pay_loads['data']['subscription']['plan']['plan_code']

          # binding.pry
            if @zoho_sub_data.valid?
              @zoho_sub_data.save
            end
            puts "Successfully Saved".green
          else
            puts "Failure in subscription".red
          end
        else
          puts "Failure in send API of Hosted page details".red
        end

      # {"sub"=>"Test-3 Months", "plan"=>"3 Months", "hostedpage_id"=>"2-8a55a069e007bc994414ee32022e961061935fc4a5cad80c21b9c48d67314df3fecbf94c9c1b92f7cd8887b17b8ad7f2", "controller"=>"api/user_subscriptions", "action"=>"zoho_test"}

      # response = RestClient.get('https://subscriptions.zoho.com/api/v1/hostedpages/2-8a55a069e007bc99f3b7add3f8a199ed61935fc4a5cad80c050fa3e2d20e50d096cfc2adf26dbb03cd8887b17b8ad7f2', {accept: :json})
      # response = RestClient.get('https://subscriptions.zoho.com/api/v1/hostedpages/2-8a55a069e007bc99f3b7add3f8a199ed61935fc4a5cad80c050fa3e2d20e50d096cfc2adf26dbb03cd8887b17b8ad7f2', {:Authorization => 'Zoho-oauthtoken 1000.eb70547d22cb5f7ecb2c5bff4b12eec2.10abe5f9eb4b99017d3780137cb5594f'})
      # data = JSON.parse(response.body)
      # binding.pry



    end

    def downgrade_subscription
      user_id = params['subscription']['user_id']
      sub_id = params['subscription']['sub_id']
      
      GeneralServices.new(user_id, nil).downgrade_plan
      # StripeChargesServices.new(nil, current_client_user, nil).delete_card  # Delete card after downgrade plan
      # StripeChargesServices.new(charges_params, current_client_user, sub_id).delete_subscription

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
      # @user_subscription = ZohoSubData.find_by('client_user_id=?',current_client_user)
      @user_subscription = UserSubscription.find_by(user_id:current_client_user)
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