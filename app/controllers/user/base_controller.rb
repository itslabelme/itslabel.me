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
    def access_denied
      #raise get_current_route.inspect
      @subcription=UserSubscription.find_by('user_id=?',current_client_user)
      #raise @subcription.id.inspect
      if @subcription.present?
        @subcription_id= @subcription.subscription_id 
      else
        @subcription_id=1
      end
      #.where('route=?',request.fullpath)
     # @access=SubscriptionModule.where('subscription_id=?',@subcription_id)
      @access=SubscriptionModule.connection.select_all("select modules_id from subscription_modules where subscription_id=#{@subcription_id}").to_a
      moduleArray = Array.new
      @access.each do |mode|
        moduleArray.push mode['modules_id']
        
      end
     
           @relation = UserModule.find_by('route = ?',("#{get_current_route}"))
         
           if !moduleArray.include?(@relation.id)
             redirect_to :user_unauthorized
            
           end
          
      end 
    
    def get_current_route
    "#{params[:controller]}##{params[:action]}"
  end
  end
end
