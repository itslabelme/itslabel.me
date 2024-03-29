module User
  class BaseController < ApplicationController 

    layout 'user'
    
    # include Devise::Controllers::Helpers 

    protected

    def authenticate_client_user!
      if client_user_signed_in?
        super
      else
        redirect_to new_client_user_session_path, :notice => 'You are not logged in or your session is expired! Please login.'
        ## if you want render 404 page
        ## render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
      end
    end

    def sec_to_min(seconds)
      return (seconds / 60) % 60
    end

    def access_denied
      

      @subcription = ZohoSubData.find_by('client_user_id=?',current_client_user)
      @user_subscription = ZohoSubData.find_by('client_user_id=?',current_client_user) # to check custemor in free plan or not

      @trial_period = (Date.today.to_date - current_client_user.created_at.to_date).to_i #Real
      # @trial_period = (Time.now - current_client_user.created_at).to_i #test based in minit
      # @trial_period_in_mint = sec_to_min(@trial_period)  #test based in minit
      

      # binding.pry
    
      # if @trial_period_in_mint >= 15 && @user_subscription.zoho_plan_code == "Free" # test based in minit
      # if @trial_period <= 0 && @user_subscription.zoho_plan_code == "Free" # for testing
      
      if @trial_period >= 7 && @user_subscription.zoho_plan_code == Rails.application.secrets.zoho_free_plan_code # Real
        
        redirect_to :user_user_subscriptions

      else
        if @subcription.present?
          @subcription_id= @subcription.subscription_id 
        else
          @subcription_id=1
        end
        
        @access=SubscriptionPermission.connection.select_all("select permission_id from subscription_permissions where subscription_id=#{@subcription_id}").to_a
        permissionArray = Array.new
        @access.each do |mode|
          permissionArray.push mode['permission_id']
        end

        @relation = Permission.find_by('route = ?',("#{get_current_route}"))
           
        if !permissionArray.include?(@relation.id)
          redirect_to :user_unauthorized
        end
      end

    end 
    
  def get_current_route
    @route="#{params[:controller]}##{params[:action]}"
       @route=@route.split("/")
      return @route[1]
  end
  end
end
