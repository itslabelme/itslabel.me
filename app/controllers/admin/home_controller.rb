module Admin
  class HomeController < Admin::BaseController

    before_action :authenticate_admin_user!

    def index

      @page_title = "Home | Admin"
      @nav = "admin/home"
      
    end
    
    private

    
    
  end
end