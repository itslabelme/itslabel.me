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
      get_subscription
      @modules=UserModule.all
      new_subscription_module  
    end   
    def create_pemission   
      new_subscription_module 
      get_subscription
      @subscriptions=Subscription.find_by_id(params[:id])
      @modules=UserModule.all.to_a
      get_collection
    end 
    # POST method for processing form data   
    def create   
      @modules=UserModule.all.to_a
      @subscription_modules = SubscriptionModule.connection.select_all("select * from subscription_modules where subscription_id=#{params['subscription_module'][:subscription_id]}").to_a
      @subscription=Subscription.find_by_id(params['subscription_module'][:subscription_id])
      SubscriptionModule.where('subscription_id',params['subscription_module'][:subscription_id]).destroy_all
      @title=params['subscription_module'][:title]
      @subscription_id=params['subscription_module'][:subscription_id]
      params[:module_id].each do |mode|
        @subscription_module=SubscriptionModule.new
    
        @subscription_module.title=@title
        @subscription_module.subscription_id=@subscription_id
        @subscription_module.modules_id=mode
        # raise @subscription_module.inspect
        if  @subscription_module.save
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

    def new_subscription_module
      @subscription_module = SubscriptionModule.new
    end
    def get_subscription
      @subscription=Subscription.find_by_id(params[:id])
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
