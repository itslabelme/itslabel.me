class HomeController < ApplicationController

  include Devise::Controllers::Helpers
  
  layout 'login'

  def index
  end

end
