class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :authenticate_user!, except: [:home]

  # include BreadcrumbsHelper
  include MetaTagsHelper
  include NavigationHelper
  include NotificationHelper
  include FlashHelper
  include PaginationHelper

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end

  private
  
  # def layout
  #   # only turn it off for login pages:
  #   is_a?(Devise::SessionsController) ? "login" : "user"
  #   # or turn layout off for every devise controller:
  #   #devise_controller? && "application"
  # end

end
