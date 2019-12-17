class HomeController < ApplicationController

  include Devise::Controllers::Helpers

  layout 'user'

  def index
  end

end
