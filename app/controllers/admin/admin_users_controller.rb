module Admin
  class AdminUsersController < Admin::BaseController

    before_action :authenticate_admin_user!

    def index

      @page_title = "Admin Users | Admin"
      
    end

  end
end
