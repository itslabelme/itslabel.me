module Admin
  class SubscriptionModulesController < Admin::BaseController
    
    before_action :authenticate_admin_user!
    before_action :get_modules, except: [:new, :create, :index,:create_pemission]
    
    def index

      @page_title = "User Module | Admin"
      @nav = 'admin/subscription_modules'
      
     # get_collection
      #new_subscription_module
     @subscriptions=Subscription.all
    end
    
    def new   
      @subscriptions=Subscription.all
      @modules=UserModule.all
      new_subscription_module  
    end   
    def create_pemission   
      @subscriptions=Subscription.find_by_id(params[:id])
      @modules=UserModule.all
      get_collection
      #sraise get_collection.inspect
      new_subscription_module  
    end 
    # POST method for processing form data   
    def create   
      
     # raise params['subscription_module'].inspect 
     # $modules=params[:module_ids]
     @title=params['subscription_module'][:title]
     @subscription_id=params['subscription_module'][:subscription_id]
      params[:module_id].each do |mode|
        @subscription_module=SubscriptionModule.new
     # subscription_module_params[:module_id]=mode
     # raise subscription_module_params.inspect
     @subscription_module.title=@title
     @subscription_module.subscription_id=@subscription_id
     @subscription_module.modules_id=mode
    # raise @subscription_module.inspect
      @subscription_module.save
        set_notification(true, I18n.t('status.success'), I18n.t('success.created', item: "Module Permissions"))
        set_flash_message(I18n.translate("success.created", item: "Module Permissions"), :success)
     
      end
    end  
     
    def edit
      @page_title = "Edit User | Admin"
      @nav = 'admin/subscription_modules'
    end

    # PATCH/PUT /subscription_module/1
    def update
      @subscription_module.assign_attributes(subscription_module_params)
      
      if @subscription_module.valid?
        @subscription_module.save
       set_notification(true, I18n.t('status.success'), I18n.t('success.updated', item: "AdminUser"))
       set_flash_message(I18n.translate("success.updated", item: "AdminUser"), :success)
      else
        message = I18n.t('errors.failed_to_update', item: "AdminUser")
        @subscription_module.errors.add :base, message
        set_notification(false, I18n.t('status.error'), message)
        set_flash_message('The form has some errors. Please correct them and submit again', :error)
      end
    end
    
    # DELETE method for deleting a user from database based on id   
    def destroy   
      if @subscription_module
        if @subscription_module.can_be_deleted?
          @subscription_module.destroy
          
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

    def new_subscription_module
      @subscription_module = SubscriptionModule.new
    end

    def get_collection
     
      
      @subscription_modules = SubscriptionModule.connection.select_all("select * from subscription_modules where subscription_id=#{params[:id]}").to_a
      
    end

    
    def get_modules
      @subscription_module = SubscriptionModule.find(params[:id])
    end
    
    def subscription_module_params
      params.require(:subscription_module).permit(
        :id,
        :title,
        :module_id,
        :subscription_id
      )
    end

  end
end
