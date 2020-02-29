module Admin
  class HomeController < Admin::BaseController

    before_action :authenticate_admin_user!

    def index

      @page_title = "Home | Admin"
      @nav = "admin/home"
      
    end

    def free_form

      @page_title = "Free Form | Admin"
      @nav = "admin/free_form"
      
    end
    
    private

    
    
  end
end