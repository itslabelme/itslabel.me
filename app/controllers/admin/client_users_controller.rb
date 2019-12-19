module Admin
  class ClientUsersController < Admin::BaseController

    before_action :authenticate_admin_user!
   
   # include PaginationHelper
    def index

      @page_title = "Client Users | Admin"
     
      @per_page=params[:page]
      @client_users = ClientUser.page(@per_page).per(@current_page)
    end

  end
end
