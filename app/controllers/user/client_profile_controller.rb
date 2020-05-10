module User
  class ClientProfileController < User::BaseController
  
    before_action :authenticate_client_user!
    before_action :get_client_user
    #before_action :access_denied, only: [:index, :new]
    
    def edit
      @page_title = "Edit Translation"
      @nav = 'user/profile'
     
    end
    
    def update
     
     @client_user.assign_attributes(permitted_params)
      
      if @client_user.valid?
        @client_user.save
       set_notification(true, I18n.t('status.success'), I18n.t('success.updated', item: "ClientUser"))
       set_flash_message(I18n.translate("success.updated", item: "ClientUser"), :success)
      else
        message = I18n.t('errors.failed_to_update', item: "ClientUser")
        @client_user.errors.add :base, message
        set_notification(false, I18n.t('status.error'), message)
        set_flash_message('The form has some errors. Please correct them and submit again', :error)
      end
    end
    
    def update_password
       @user=current_client_user
       
       if @user.update_with_password(permitted_params)
          set_notification(true, I18n.t('status.success'), I18n.t('success.updated', item: "Password"))
      else
        message = I18n.t('errors.failed_to_update', item: "Password")
        @user.errors.add :base, message
        set_notification(false, I18n.t('status.error'), message)
      end
    end
    
    
    private
    
     def get_client_user
      @client_user = current_client_user
    end
   
   def permitted_params
      params.require(:client_user).permit(
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

