module User
  class ClientProfileController < User::BaseController
    before_action :set_profile, only: [:index,:edit, :update,:update_password]
    before_action :authenticate_client_user!
    
    def index
      @page_title = "User Profile | User"
      @nav = 'user/profile'
    
    end
    
    def show
    end
    
    def new   
    end 
    
    def create
    end
    
    def edit
      @page_title = "Edit Translation"
      @nav = 'user/profile'
      set_profile
    end
    
    def update
     # set_admin_user
      #raise params.inspect
     @client_user.assign_attributes(client_user_params)
      
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
    
    def update_client_password
          @user=current_client_user
          raise params.inspect
       if @user.update_with_password(client_user_params)
      set_notification(true, I18n.t('status.success'), I18n.t('success.updated', item: "ClientUser"))
       set_flash_message(I18n.translate("success.updated", item: "ClientUser"), :success)
      else
        message = I18n.t('errors.failed_to_update', item: "ClientUser")
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
      @client_user = ClientUser.find_by_id(current_client_user)
    end
   def user_params
   
    params.require(:user).permit(
        :id,
        :password,
        :current_password,
        :password_confirmation)
   end
   def client_user_params
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

