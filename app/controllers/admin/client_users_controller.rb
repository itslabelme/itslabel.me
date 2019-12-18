module Admin
  class ClientUsersController < Admin::BaseController

    before_action :authenticate_admin_user!

    def index

      @page_title = "Client Users | Admin"
      @client_users = ClientUser.all
    end

  end
end
