module Admin
  class ProfileController < Admin::BaseController
    
    before_action :authenticate_admin_user!
    before_action :get_admin_user
    
    def edit
      @page_title = "My Profile | Admin"
      @nav = 'admin/profile'
    end
    
    def update
      @admin_user.assign_attributes(permitted_params)
      
      if @admin_user.valid?
        @admin_user.save
        set_notification(true, I18n.t('status.success'), I18n.t('success.updated', item: "Admin User"))
      else
        message = I18n.t('errors.failed_to_update', item: "Admin User")
        @admin_user.errors.add :base, message
        set_notification(false, I18n.t('status.error'), message)
      end
    end
    
    def update_password
      @user = current_admin_user
      if @user.valid? 
        @user.update_with_password(permitted_params)
        set_notification(true, I18n.t('status.success'), I18n.t('success.updated', item: "Admin User"))
      else
        message = I18n.t('errors.failed_to_update', item: "Admin User")
        @user.errors.add :base, message
        set_notification(false, I18n.t('status.error'), message)
      end
    end
    
    
    private

    def get_admin_user
      @admin_user = current_admin_user
    end

    def permitted_params
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
