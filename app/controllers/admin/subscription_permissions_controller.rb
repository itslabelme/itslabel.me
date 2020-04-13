module Admin
  class SubscriptionPermissionsController < Admin::BaseController
    
    before_action :authenticate_admin_user!
    before_action :get_permissions, except: [:new, :create, :index,:create_pemission]
    
    def index

      @page_title = "Subscription Permission | Admin"
      @nav = 'admin/subscription_permissions'
      
      # get_collection
      #new_subscription_module
      @subscriptions=Subscription.all
    end
    
    def new   
      get_subscription
      @permissions=Permission.all
      new_subscription_permission
    end   
    def create_pemission   
      new_subscription_permission
      get_subscription
      @subscriptions=Subscription.find_by_id(params[:id])
      @permissions=Permission.all.to_a
      get_collection
    end 
    # POST method for processing form data   
    def create
      new_subscription_permission
      @permissions=Permission.all.to_a
      # @subscription_permissions = SubscriptionPermission.connection.select_all("select * from subscription_permissions where subscription_id=#{params['subscription_permission'][:subscription_id]}").to_a
      # @subscription=Subscription.find_by_id(params['subscription_permission'][:subscription_id])
      SubscriptionPermission.where(:subscription_id=> params['subscription_permission'][:subscription_id]).delete_all
      #raise params['subscription_module'][:subscription_id]
      @title=params['subscription_permission'][:title]
      @subscription_id=params['subscription_permission'][:subscription_id]
      #raise params[:module_id].inspects
      params[:permission_id].each do |mode|
        @subscription_permission=SubscriptionPermission.new

        @subscription_permission.title=@title
        @subscription_permission.subscription_id=@subscription_id
        @subscription_permission.permission_id=mode

        if  @subscription_permission.save
         set_notification(true, I18n.t('status.success'), I18n.t('success.created', item: "SubscriptionModule"))

       end
      end
    end  
     
    def edit
      @page_title = "Edit User | Admin"
      @nav = 'admin/subscription_modules'
    end

    # PATCH/PUT /subscription_module/1
    def update
     s
    end
    
    # DELETE method for deleting a user from database based on id   
    def destroy   
     
    end
    
    private

    def new_subscription_permission
      @subscription_permission = SubscriptionPermission.new
    end
    def get_subscription
      @subscription=Subscription.find_by_id(params[:id])
    end
    def get_collection
      @subscription_permissions = SubscriptionPermission.connection.select_all("select * from subscription_permissions where subscription_id=#{params[:id]}").to_a
    end

    
    def get_permissions
      @subscription_permission = Permission.find(params[:id])
    end
    
    def subscription_module_params
      params.require(:subscription_permission).permit(
        :id,
        :title,
        :permission_id,
        :subscription_id
      )
    end

  end
end
