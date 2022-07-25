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
      # out_hash = Hash.from_xml(request.body.read.gsub("\n", "").gsub("\n", ""))
      # puts out_hash

      payload = request.body.read
      payld_data = JSON.parse(payload, symbolize_names: true)
      payld_event = Stripe::Event.construct_from(payld_data)

      # Get the type of webhook event sent - used to check the status of PaymentIntents.
      event_type = payld_event['type']
      data = payld_event['data']
      data_object = data['object']

      puts "------ >>>>>>>> -"
      puts event_type
      # puts data_object


      if event_type == 'customer.created'
        puts "------- customer.created --------- "
        puts event_type
        puts data_object
      end

      if event_type == 'customer.updated'
        puts "------ customer.updated ------------>>> "
        # puts data_object
      end

      if event_type == 'invoice.upcoming'
        puts "------ invoice.upcoming ------------>>> "
        # puts data_object
      end

      if event_type == 'invoice.created'
        puts "------ invoice.created ------------>>> "
        # puts data_object
      end

      if event_type == 'invoice.finalized'
        puts "------ invoice.finalized ------------>>> "
        # puts data_object
      end

      if event_type == 'invoice.payment_succeeded'
        puts "------ invoice.payment_succeeded ------------>>> "
        # puts data_object
      end

      if event_type == 'invoice.payment_failed'
        puts "------ invoice.payment_failed ------------>>> "
        # puts data_object
      end


      if event_type == 'charge.pending'
        puts "------ Charge Pending ------------>>> "
      end

      if event_type == 'charge.failed'
        puts "------ Charge Failed ------------>>> "
      end

      if event_type == 'payment_intent.succeeded'
        puts "------ payment_intent.succeeded ------------>>> "
        # puts data_object
      end

      if event_type == 'customer.subscription.created'
        puts "------ customer.subscription.created ------------>>> "
        # puts data_object
      end

      render json: {"status": "success"}


      # puts payld_data
      # puts payld_data[:id]
      # data = payld_data['data']

      # puts payload.class
      # puts payld_data['id']
      # puts payld_data['type']
      # puts data['object']

      # puts event['id']
      # puts event['type']
      # data = event['data']
      # puts data['object']



      # # webhook_secret = ENV['STRIPE_WEBHOOK_SECRET']
      # webhook_secret = Rails.configuration.stripe[:stripe_webhook_secret_key]
      # payload = request.body.read

      # binding.pry 

      # if !webhook_secret.empty?
      #   # Retrieve the event by verifying the signature using the raw body and secret if webhook signing is configured.
      #   sig_header = request.env['HTTP_STRIPE_SIGNATURE']
      #   event = nil

      #   begin
      #     event = Stripe::Webhook.construct_event(
      #       payload, sig_header, webhook_secret
      #     )
      #   rescue JSON::ParserError => e
      #     # Invalid payload
      #     status 400
      #     return
      #   rescue Stripe::SignatureVerificationError => e
      #     # Invalid signature
      #     puts '⚠️  Webhook signature verification failed.'
      #     status 400
      #     return
      #   end
      # else
      #   data = JSON.parse(payload, symbolize_names: true)
      #   event = Stripe::Event.construct_from(data)
      # end
      # # Get the type of webhook event sent - used to check the status of PaymentIntents.
      # event_type = event['type']
      # data = event['data']
      # data_object = data['object']

      # puts "------data_object = >>>>>>>>>  #{data_object}"

      # if event_type == 'customer.created'
      #   # puts data_object
      # end

      # if event_type == 'customer.updated'
      #   # puts data_object
      # end

      # if event_type == 'invoice.upcoming'
      #   # puts data_object
      # end

      # if event_type == 'invoice.created'
      #   # puts data_object
      # end

      # if event_type == 'invoice.finalized'
      #   # puts data_object
      # end

      # if event_type == 'invoice.payment_succeeded'
      #   # puts data_object
      # end

      # if event_type == 'invoice.payment_failed'
      #   # puts data_object
      # end

      # if event_type == 'customer.subscription.created'
      #   # puts data_object
      # end

      # content_type 'application/json'
      # {
      #   status: 'success'
      # }.to_json





      # puts "------------------ ** Testing API result POST ** -----------------".white
      # puts " Params in Post".white
      # puts params['Parameters']
      # puts params
      # payload = request.body.read


      # Its working------>>
      # payload = Hash.from_xml(request.body.read)
      # payload = Hash.from_xml(response).to_json
      # puts payload

      # out_hash = Hash.from_xml(request.body.read)
      # out_hash = Hash.from_xml(request.body.read.gsub("\n", ""))
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