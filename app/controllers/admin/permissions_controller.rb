module Admin
  class ModulesController < Admin::BaseController
    
   before_action :authenticate_admin_user!
    before_action :get_user, except: [:new, :create, :index]
    
    def index

      @page_title = "User Module | Admin"
      @nav = 'admin/admin_users'

      get_collection
      new_admin_user

      # if (params.has_key? (:q))
      #   get_search
      # else
      #   if (params.has_key?( params[:country]) || (params[:name]) || (params[:mobile_number]))
      #     get_advanced_search
      #   else
      #     get_collection
      #   end
      # end 
    end
    
    def new   
      new_admin_user  
    end   
   
    # POST method for processing form data   
    def create   
      new_admin_user
      @admin_user.assign_attributes(admin_user_params)
     
      if @admin_user.valid?
        @admin_user.save
        set_notification(true, I18n.t('status.success'), I18n.t('success.created', item: "AdminUsers"))
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
      @nav = 'admin/admin_users'
    end

    # PATCH/PUT /admin_user/1
    def update
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
    
    # DELETE method for deleting a user from database based on id   
    def destroy   
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
    
    private

    def new_admin_user
      @admin_user = AdminUser.new
    end

    def get_collection
      @order_by = "created_at DESC" unless @order_by

      @relation = AdminUser.where("")

      apply_filters

      @admin_users = @relation.order(@order_by).page(@current_page).per(@per_page)
    end

    def apply_filters
      @query = params[:q]
      @relation = @relation.search(@query) if @query && !@query.blank?
    end
    
    def get_user
      @admin_user = AdminUser.find(params[:id])
    end
    
    def admin_user_params
      params.require(:admin_user).permit(
        :id,
        :first_name,
        :last_name,
        :mobile_number,
        :email,
        :password,
        :password_confirmation)
    end

  end
end
