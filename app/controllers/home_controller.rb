 class HomeController < ActionController::Base

   

    def index

      @page_title = "Home | User"
      @nav = 'user/home'
      
    end

  end
