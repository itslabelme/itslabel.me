class ApplicationController < ActionController::Base

  # include BreadcrumbsHelper
  include MetaTagsHelper
  include NavigationHelper
  include NotificationHelper
  include FlashHelper
  include PaginationHelper

  include General::FlashConcern
  include Devise::Controllers::Helpers

  protect_from_forgery with: :exception
  prepend_before_action :check_captcha, only: [:create]
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_default_page_title

  before_action :configure_notification
  before_action :parse_pagination_params
  # before_action :authenticate_user!, except: [:home]

  protected

  def configure_permitted_parameters
  # commented by Athira
  # devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :mobile_number,:position,:country_code,:time_zone, :country, :organisation, :t_c_accepted, :flag])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :mobile_number,:position,:country_code,:time_zone, :country, :organisation, :t_c_accepted])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :mobile_number,:position,:country_code,:time_zone, :country, :organisation])
  end

  private

  def check_captcha
    if verify_recaptcha(action: 'signup')
      self.resource = resource_class.new configure_permitted_parameters
      #flash.now[:error] = "Recaptcha cannot be blank; please try again"
      respond_with_navigational(resource) { render :new }
    end
  end

  def set_default_page_title 
    @page_title = "ITS Label"
  end

  def welcome_path
    resource.is_a?(ClientUser) ? :user_home : :admin_home
  end

  def after_sign_in_path_for(resource)
   if resource.is_a?(AdminUser)
        admin_root_path
    else
        user_root_path
    end
    #stored_location_for(resource) || welcome_path
  end

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource)
    resource == :client_user ? :user_home : :admin_home
  end

  def after_sign_up_path_for(resource)
    welcome_path
  end

  def after_inactive_sign_up_path_for(resource)
    welcome_path
  end
   
end
