module Admin
  class ClientUsersController < Admin::BaseController

    before_action :authenticate_admin_user!

    def index

      @page_title = "Client Users | Admin"

    end

  end
end
