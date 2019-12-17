module User
  class BaseController < ApplicationController

    layout 'user'

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

  end
end
