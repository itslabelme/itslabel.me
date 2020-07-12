module User
  class ErrorsController < User::BaseController

    before_action :authenticate_client_user!
    
    def unauthorized
      flash.alert = 'Unauthorized access'
     # render status:403
    end


  end
end
