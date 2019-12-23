module Admin
  class ClientUsersController < Admin::BaseController

    before_action :authenticate_admin_user!
   
   # include PaginationHelper
    def index

      @page_title = "Client Users | Admin"
     
      @per_page=params[:page]
     
      if (params.has_key? (:q))
         key = "%#{params[:q]}%"
      
      @client_users = ClientUser.where('first_name LIKE :search OR last_name LIKE :search OR email LIKE :search', search: key).page(@per_page).per(@current_page)
      else
       @client_users = ClientUser.page(@per_page).per(@current_page)  
      end
    end
    
     # GET /client_iser/1
    def show
      @user = ClientUser.find(params[:id])  
    end
  end
end
