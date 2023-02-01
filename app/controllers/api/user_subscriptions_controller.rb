module Api
  class UserSubscriptionsController < Api::BaseController
    
    skip_before_action :verify_authenticity_token


    def zoho_test
      # binding.pry
      Rails.logger.debug( "enter in zoho_test function ")
      payload = request.body.read
      payld_data = JSON.parse(payload, symbolize_names: true)
      Rails.logger.debug(payld_data)
    end

    def zoho_test2
      # binding.pry
      Rails.logger.debug( "enter in zoho_test function 2 ")
      payload = request.body.read
      payld_data = JSON.parse(payload, symbolize_names: true)
      Rails.logger.debug(payld_data)
    end
    
    
    def downgrading_api
      
      payload = request.body.read
      payld_data = JSON.parse(payload, symbolize_names: true)
      payld_event = Stripe::Event.construct_from(payld_data)

      # Get the type of webhook event sent - used to check the status of PaymentIntents.
      event_type = payld_event['type']
      data = payld_event['data']
      data_object = data['object']

      Rails.logger.debug("In downgrading_api and the Event Type =  #{event_type}")
      # Rails.logger.debug(data_object)
      
      if ['payment_intent.requires_action', 'charge.failed'].include?(event_type)
        # check for stripe customer id from the payload
        if payld_data[:data] && payld_data[:data][:object] && payld_data[:data][:object][:customer]
          
          customer_token = payld_data[:data][:object][:customer]
          customer = ClientUser.find_by_stripe_token(customer_token)

          Rails.logger.debug( "customer id id #{customer.id}")
          GeneralServices.new(customer.id, nil).downgrade_plan
          # StripeChargesServices.new(nil, customer.id, nil).delete_card # Delete card after downgrade plan

          render json: {"status": "success"}
        else
          Rails.logger.debug("Enterd in else part of payld_data[:data][:object][:customer] ")
          render json: {"status": "failed", errors: ["customer id missing in stripe payload"]}
        end
      else
          Rails.logger.debug( "Enterd in else part of payment_intent.requires_action and charge failed condition")
        render json: {"status": "failed", errors: ["uncaptured stripe event #{event_type}"]}
      end
    end
    
    def test_api
      payload = request.body.read
      payld_data = JSON.parse(payload, symbolize_names: true)
      payld_event = Stripe::Event.construct_from(payld_data)

      # Get the type of webhook event sent - used to check the status of PaymentIntents.
      event_type = payld_event['type']
      data = payld_event['data']
      data_object = data['object']

      Rails.logger.debug("In downgrading_api and the Event Type =  #{event_type}")
      # Rails.logger.debug( data_object)

      if ['payment_intent.requires_action', 'charge.failed'].include?(event_type)
        # check for stripe customer id from the payload
        if payld_data[:data] && payld_data[:data][:object] && payld_data[:data][:object][:customer]
          
          customer_token = payld_data[:data][:object][:customer]
          customer = ClientUser.find_by_stripe_token(customer_token)

          Rails.logger.debug( "customer id is #{customer.id}")
          # costomer_in_jsonfrmt = customer.as_json
          # GeneralServices.new(customer.id, nil).downgrade_plan

          render json: {"status": "success"}
        else
          Rails.logger.debug("Enterd in else part of payld_data[:data][:object][:customer] ")
          render json: {"status": "failed", errors: ["customer id missing in stripe payload"]}
        end
      else
        Rails.logger.debug("Enterd in else part of payment_intent.requires_action and charge failed condition")
        render json: {"status": "failed", errors: ["uncaptured stripe event #{event_type}"]}
      end
    end
  end
end