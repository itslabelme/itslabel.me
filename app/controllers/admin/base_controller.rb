module Admin
  class BaseController < ApplicationController

    layout 'admin'

    protected

    def authenticate_admin_user!
      if admin_user_signed_in?
        super
      else
        redirect_to new_admin_user_session_path, :notice => 'Please login'
        ## if you want render 404 page
        ## render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
      end
    end

    def after_sign_in_path_for(resource)
      stored_location_for(resource) || :admin_home
    end

    def after_sign_up_path_for(resource)
      :admin_home
    end

    def after_inactive_sign_up_path_for(resource)
      :admin_home
    end

  end
end
