module Admin
  class ProfileController < Admin::BaseController
    before_action :set_profile, only: [:index,:edit, :update,:update_password]
    before_action :authenticate_admin_user!
    
    def index
      @page_title = "User Profile | Admin"
      @nav = 'admin/profile'
    
    end
    
    def show
    end
    
    def new   
    end 
    
    def create
    end
    
    def edit
      @page_title = "Edit Translation"
      @nav = 'admin/translations'
      set_profile
    end
    
    def update
     # set_admin_user
      #raise params.inspect
     @admin_user.assign_attributes(admin_user_params)
      
      if @admin_user.valid?
        @admin_user.save
       set_notification(true, I18n.t('status.success'), I18n.t('success.updated', item: "AdminUser"))
       set_flash_message(I18n.translate("success.updated", item: "AdminUser"), :success)
      else
        message = I18n.t('errors.failed_to_update', item: "AdminUser")
        @admin_user.errors.add :base, message
        set_notification(false, I18n.t('status.error'), message)
        set_flash_message('The form has some errors. Please correct them and submit again', :error)
      end
    end
    
    def update_password
          @user=current_admin_user
       if @user.update_with_password(user_params)
      set_notification(true, I18n.t('status.success'), I18n.t('success.updated', item: "AdminUser"))
       set_flash_message(I18n.translate("success.updated", item: "AdminUser"), :success)
      else
        message = I18n.t('errors.failed_to_update', item: "AdminUser")
        @user.errors.add :base, message
        set_notification(false, I18n.t('status.error'), message)
        set_flash_message('The form has some errors. Please correct them and submit again', :error)
      end
    end
    
    
    def destroy
    end
    
    private
    def configure_permitted_parameters
     devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:password, :password_confirmation, :current_password)}
    end
     def set_profile
      @admin_user = AdminUser.find_by_id(current_admin_user)
    end
   def user_params
    # NOTE: Using `strong_parameters` gem
    params.require(:user).permit(
        :id,
        :password,
        :current_password,
        :password_confirmation)
   end
   def admin_user_params
      params.require(:admin_user).permit(
        :id,
        :first_name,
        :last_name,
        :mobile_number,
        :email,
        :password,
        :current_password,
        :password_confirmation)
    end
  end
end
