class HomeController < ActionController::Base
  
  layout 'login'
  
  def index
    @page_title = "Home | User"
    @nav = 'user/home'
  end

end