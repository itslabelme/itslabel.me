module Admin
  class ClientUsersController < Admin::BaseController

    before_action :authenticate_admin_user!
    before_action :get_client_user, except: [:new, :create, :index]
    
    def index
      @page_title = "Client Users"
      @nav = "admin/registrations"
      
      get_collection
    end
    
    def show
    end
  
    private 

    def get_client_user
      @client_user = ClientUser.find_by_id(params[:id])
    end
  
    def get_collection
      @order_by = "created_at DESC" unless @order_by
      @client_users = ClientUser.
        order(@order_by).
        page(@current_page).per(@per_page)
    end
    
  end
end
