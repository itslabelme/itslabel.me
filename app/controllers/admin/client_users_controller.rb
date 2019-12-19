module Admin
  class ClientUsersController < Admin::BaseController

    before_action :authenticate_admin_user!
   
    def index

      @page_title = "Client Users | Admin"
      @client_users = ClientUser.page(@per_page).per(@current_page)
    end

  end
end
