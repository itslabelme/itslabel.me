module Api
  class BaseController < ApplicationController 

    # layout 'user'
    
    # include Devise::Controllers::Helpers 

    # protected

    # def authenticate_client_user!
    #   if client_user_signed_in?
    #     super
    #   else
    #     redirect_to new_client_user_session_path, :notice => 'You are not logged in or your session is expired! Please login.'
    #     ## if you want render 404 page
    #     ## render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
    #   end
    # end
    # def access_denied
      
    #   @subcription=UserSubscription.find_by('user_id=?',current_client_user)
     
    #   if @subcription.subscription.title == "Free"
    #     redirect_to :user_user_subscriptions
    #   else
    #     if @subcription.present?
    #       @subcription_id= @subcription.subscription_id 
    #     else
    #       @subcription_id=1
    #     end

    #     # binding.pry 
        
    #     @access=SubscriptionPermission.connection.select_all("select permission_id from subscription_permissions where subscription_id=#{@subcription_id}").to_a
    #     permissionArray = Array.new
    #     @access.each do |mode|
    #       permissionArray.push mode['permission_id']
    #     end

    #     @relation = Permission.find_by('route = ?',("#{get_current_route}"))
           
    #     if !permissionArray.include?(@relation.id)
    #       redirect_to :user_unauthorized
    #     end
    #   end

    # end 
    
    # def get_current_route
    #   @route="#{params[:controller]}##{params[:action]}"
    #      @route=@route.split("/")
    #     return @route[1]
    # end
  end
end
