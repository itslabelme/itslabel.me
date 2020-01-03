module Admin
  class AdminUsersController < Admin::BaseController
    
    before_action :authenticate_admin_user!
    before_action :get_user, except: [:new, :create, :index]
    def index

      @page_title = "Admin Users | Admin"
      @per_page=2
      get_collection
      if (params.has_key? (:q))
        get_search
        new_adminuser
      else
        get_collection
        new_adminuser
      end
        
    end
    
    def new   
      new_adminuser  
    end   
   
    # POST method for processing form data   
    def create   
      new_adminuser
      @admin_user.assign_attributes(admin_user_params)
     

      if @admin_user.valid?
        @admin_user.save
        set_notification(true, I18n.t('status.success'), I18n.t('success.created', item: "AdminUser"))
        set_flash_message(I18n.translate("success.created", item: "AdminUsers"), :success)
      else
        @per_page=params[:page]
        message = I18n.t('errors.failed_to_create', item: "AdminUser")
        @admin_user.errors.add :base, message
        set_notification(false, I18n.t('status.error'), message)
        set_flash_message('The form has some errors. Please correct them and submit again', :error)
      end
   
    end  
     
    
    def edit
      @page_title = "Edit User | Admin"
      get_user
    end
    # PATCH/PUT /admin_user/1
    def update
      
      get_user
      @admin_user.assign_attributes(admin_user_params)
      
      if @admin_user.valid?
        @admin_user.save
        set_notification(true, I18n.t('status.success'), I18n.t('success.updated', item: "AdminUser"))
        set_flash_message(I18n.translate("success.updated", item: "AdminUsers"), :success)
      else
        message = I18n.t('errors.failed_to_update', item: "AdminUser")
        @admin_user.errors.add :base, message
        set_notification(false, I18n.t('status.error'), message)
        set_flash_message('The form has some errors. Please correct them and submit again', :error)
      end
    end
    
    
    def show
      get_user
    end
   
    # DELETE method for deleting a user from database based on id   
    def destroy   
      get_user

      if @admin_user
        if @admin_user.can_be_deleted?
          @admin_user.destroy
          
          set_notification(false, I18n.t('status.success', item: "AdminUser"), I18n.t('success.deleted', item: "AdminUser"))
          set_flash_message(I18n.t('success.deleted', item: "AdminUser"), :success, false)
          @destroyed = true
        else
          message = I18n.t('errors.cannot_be_deleted', item: "AdminUser", reason: @admin_suser.errors.full_messages.join("<br>"))
          set_flash_message(message, :failure)
          set_notification(false, I18n.t('status.error'), message)
          @destroyed = false
        end
      end  
    end
    
    def new_adminuser
      @admin_user = AdminUser.new
    end
    
    private 
    def get_collection
      #@per_page=params[:page]
      @order_by = "created_at DESC" unless @order_by
      @admin_users = AdminUser.
        order(@order_by).
        page(@current_page).per(@per_page)
    end
    
    def get_search
      #s @per_page=params[:page]
      key = "%#{params[:q]}%"
      
      @admin_users = AdminUser.where('first_name LIKE :search OR last_name LIKE :search OR email LIKE :search', search: key).page(@current_page).per(@per_page)
      
      
    end
     
    def get_user
      @admin_user = AdminUser.find(params[:id])
    end
    
    def admin_user_params
      params.require(:admin_user).permit(
        :id,
        :first_name,
        :last_name,
        :password,
        :password_confirmation,
        :email,
        :organisation,
        :phone)
    end
     
      
    
  end
end
