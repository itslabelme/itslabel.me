module Api
  class UserSubscriptionsController < Api::BaseController
    skip_before_action :verify_authenticity_token
    


    def api_downgrade
      user_id = params['subscription']['user_id']
      GeneralServices.new(user_id, nil).downgrade_plan
      render json: {"status": "Done"}
    end
    
    def test_api
      puts "------------------ ** Testing API result ** -----------------".white
      puts " Params ".white
      puts params.to_json
      puts params['subscription'].to_json
      render json: {"status": "Done"}

    end



  end
end