module Admin
  class ClientUsersController < Admin::BaseController

    before_action :authenticate_admin_user!
    # include PaginationHelper

    def index

      @page_title = "Client Users | Admin"
      @nav = "admin/registrations"
      
      get_collection  
      @per_page=2
     
      if (params.has_key? (:q))
        # key = "%#{params[:q]}%"
        get_search
      else
        get_collection  
      end
    end
    
    # GET /client_user/1
    def show
      get_user 
    end
  
  
    private 
  
    def get_collection
      #@per_page=params[:page]
      @order_by = "created_at DESC" unless @order_by
      @client_users = ClientUser.
        order(@order_by).
        page(@current_page).per(@per_page)
    end
    
    def get_search
      #s @per_page=params[:page]
      key = "%#{params[:q]}%"
      @admin_users = ClientUser.where('first_name LIKE :search OR last_name LIKE :search OR email LIKE :search', search: key).page(@current_page).per(@per_page)
    end
     
    def get_user
      @user = ClientUser.find(params[:id])
    end
  end
end
