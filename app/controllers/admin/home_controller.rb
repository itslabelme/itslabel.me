module Admin
  class HomeController < Admin::BaseController

    before_action :authenticate_admin_user!

    def index

      @page_title = "Home | Admin"

    end

  end
end
