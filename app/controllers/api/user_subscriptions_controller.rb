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
      # puts params
      # payload = request.body.read


      # Its working------>>
      payload = Hash.from_xml(request.body.read)
      # payload = Hash.from_xml(response).to_json
      puts payload

      # out_hash = Hash.from_xml(response.body.gsub("\n", ""))
      # puts out_hash
      # puts out_hash.Parameters


      # payload = request.body.read
      # sig_header = request.env['HTTP_STRIPE_SIGNATURE']
      # event = nil

      # begin
      #   event = Stripe::Webhook.construct_event(
      #     payload, sig_header, Rails.application.credentials[:stripe][:webhook]
      #   )
      # rescue JSON::ParserError => e
      #   status 400
      #   return
      # rescue Stripe::SignatureVerificationError => e
      #   # Invalid signature
      #   puts "Signature error"
      #   p e
      #   return
      # end
      # puts event



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