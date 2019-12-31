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
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_default_page_title

  before_action :configure_notification
  before_action :parse_pagination_params
  # before_action :authenticate_user!, except: [:home]

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end

  private

  def set_default_page_title 
    @page_title = "ITS Label"
  end

  def welcome_path
    resource.is_a?(ClientUser) ? :user_home : :admin_home
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || welcome_path
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
