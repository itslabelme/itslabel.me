class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_default_page_title

  # before_action :authenticate_user!, except: [:home]

  # include BreadcrumbsHelper
  include MetaTagsHelper
  include NavigationHelper
  include NotificationHelper
  include FlashHelper
  include PaginationHelper

  include Devise::Controllers::Helpers

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end

  private

  def set_default_page_title 
    @page_title = "ITS Label"
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || welcome_path
  end

  def welcome_path
    resource.is_a?(ClientUser) ? :user_home : :admin_home
  end

  def after_sign_up_path_for(resource)
    welcome_path
  end

  def after_inactive_sign_up_path_for(resource)
    welcome_path
  end


end
