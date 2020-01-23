module User
  class HomeController < User::BaseController

    before_action :authenticate_client_user!

    def index

      @page_title = "Home | User"
      @nav = 'user/home'
      
    end

  end
end
