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

      # puts event_type
      # puts data_object


      # if event_type == 'customer.created'
      #   Rails.logger.debug("------- customer.created --------- ")
      #   Rails.logger.debug(data_object)
      # end

      # if event_type == 'customer.updated'
      #   Rails.logger.debug("------ customer.updated ------------>>> ")
      #   Rails.logger.debug(data_object)
      #   # puts data_object
      # end

      # if event_type == 'invoice.upcoming'
      #   Rails.logger.debug("------ invoice.upcoming ------------>>> ")
      #   Rails.logger.debug(data_object)
      #   # puts data_object
      # end

      # if event_type == 'invoice.paid'
      #   Rails.logger.debug("------ invoice.paid ------------>>> ")
      #   Rails.logger.debug(data_object)
      # end

      # if event_type == 'invoice.created'
      #   Rails.logger.debug("------ invoice.created ------------>>> ")
      #   Rails.logger.debug(data_object)
      #   # puts data_object
      # end

      # if event_type == 'invoice.finalized'
      #   Rails.logger.debug("------ invoice.finalized ------------>>> ")
      #   Rails.logger.debug(data_object)
      #   # puts data_object
      # end

      # if event_type == 'invoice.payment_succeeded'
      #   Rails.logger.debug("------ invoice.payment_succeeded ------------>>> ")
      #   Rails.logger.debug(data_object)
      #   # puts data_object
      # end

      # if event_type == 'invoice.payment_failed'
      #   Rails.logger.debug("------ invoice.payment_failed ------------>>> ")
      #   Rails.logger.debug(data_object)
      #   # puts data_object
      # end

      # if event_type == 'invoice.upcoming'
      #   Rails.logger.debug("------ invoice.upcoming ------------>>> ")
      #   Rails.logger.debug(data_object)
      # end

      # if event_type == 'charge.captured'
      #   Rails.logger.debug("------ Charge captured ------------>>> ")
      #   Rails.logger.debug(data_object)
      # end

      # if event_type == 'charge.expired'
      #   Rails.logger.debug("------ Charge expired ------------>>> ")
      #   Rails.logger.debug(data_object)
      # end

      # if event_type == 'charge.updated'
      #   Rails.logger.debug("------ Charge updated ------------>>> ")
      #   Rails.logger.debug(data_object)
      # end

      # if event_type == 'charge.refunded'
      #   Rails.logger.debug("------ Charge refunded ------------>>> ")
      #   Rails.logger.debug(data_object)
      # end

      # if event_type == 'charge.succeeded'
      #   Rails.logger.debug("------ Charge succeeded ------------>>> ")
      #   Rails.logger.debug(data_object)
      # end

      # if event_type == 'charge.pending'
      #   Rails.logger.debug("------ Charge Pending ------------>>> ")
      #   Rails.logger.debug(data_object)
      # end

      # if event_type == 'charge.failed'
      #   Rails.logger.debug("------ Charge Failed ------------>>> ")
      #   Rails.logger.debug(data_object)
      # end

      # if event_type == 'payment_intent.succeeded'
      #   Rails.logger.debug("------ payment_intent.succeeded ------------>>> ")
      #   Rails.logger.debug(data_object)
      #   # puts data_object
      # end
      # if event_type == 'setup_intent.succeeded'
      #   Rails.logger.debug("------ setup_intent.succeeded ------------>>> ")
      #   Rails.logger.debug(data_object)
      # end

      # if event_type == 'setup_intent.created'
      #   Rails.logger.debug("------ setup_intent.created ------------>>> ")
      #   Rails.logger.debug(data_object)
      # end

      # if event_type == 'customer.subscription.created'
      #   Rails.logger.debug("------ customer.subscription.created ------------>>> ")
      #   Rails.logger.debug(data_object)
      #   # puts data_object
      # end
      # render json: {"status": "success"}
    end


    


  end
end