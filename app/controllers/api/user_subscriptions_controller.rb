module Api
  class UserSubscriptionsController < Api::BaseController
    skip_before_action :verify_authenticity_token
    


    def api_downgrade
      user_id = params['subscription']['user_id']
      GeneralServices.new(user_id, nil).downgrade_plan

      # case event.type
      # when "invoice.created"

      #   GeneralServices.new(user_id, nil).downgrade_plan

      # when "customer.subscription.created"

      #   GeneralServices.new(user_id, nil).downgrade_plan

      # when "customer.subscription.created"

      #   GeneralServices.new(user_id, nil).downgrade_plan

      # end


      render json: {"status": "Done"}
    end
    
    def test_api
      # puts "------------------ ** Testing API result POST ** -----------------".white
      # puts " Params in Post".white
      # puts params['Parameters']
      puts params
      # puts params['subscription'].to_json
      render json: {"status": "Done"}

    end

    def test_api_2
      # puts "------------------ ** Testing API result GET ** -----------------".white
      # puts " Params in get".white
      # puts params.to_json
      # puts params['subscription'].to_json
      render json: {"status": "Done"}

    end


  end
end

# http://demo.itslabel.me/api/test_api
# http://demo.itslabel.me/api/api_downgrade