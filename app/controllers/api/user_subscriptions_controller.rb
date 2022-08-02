module Api
  class UserSubscriptionsController < Api::BaseController
    
    skip_before_action :verify_authenticity_token

    # def downgrading_api
      
    #   puts "<<<<<<<< === downgrading_api === >>>>>>>>>>>>"

    #   # user_id = params['subscription']['user_id']
    #   # GeneralServices.new(user_id, nil).downgrade_plan
    #   # case event.type
    #   # when "invoice.created"
    #   #   GeneralServices.new(user_id, nil).downgrade_plan
    #   # when "customer.subscription.created"
    #   #   GeneralServices.new(user_id, nil).downgrade_plan
    #   # when "customer.subscription.created"
    #   #   GeneralServices.new(user_id, nil).downgrade_plan
    #   # end

    #   render json: {"status": "Done"}
    # end
    
    # def handle_charge_failed
    def downgrading_api
      
      payload = request.body.read
      payld_data = JSON.parse(payload, symbolize_names: true)
      payld_event = Stripe::Event.construct_from(payld_data)

      # Get the type of webhook event sent - used to check the status of PaymentIntents.
      event_type = payld_event['type']
      
      # data = payld_event['data']
      # data_object = data['object']

      Rails.logger.debug( "------ >>>>>>>> - downgrading_api - <<<<<<<< ------- ")
      Rails.logger.debug("------- Event Type: #{event_type} --------- ")
      Rails.logger.debug(data_object)
      
      if ['payment_intent.requires_action', 'charge.failed'].include?(event_type)
        # check for stripe customer id from the payload
        if payld_data[:data] && payld_data[:data][:object] && payld_data[:data][:object][:customer]
          
          customer_id = payld_data[:data][:object][:customer]
          # customer = ClientUser.find_by_stripe_token(customer_id)
          # customer.downgrade_to_free_plan()

          Rails.logger.debug( "------ >>>>>>>>  customer_id  <<<<<<<< ------- #{customer_id}")

          # GeneralServices.new(customer.id, nil).downgrade_plan

          render json: {"status": "success"}
        else
          Rails.logger.debug( "------ >>>>>>>>  error on payld_data  <<<<<<<< -------")
          render json: {"status": "failed", errors: ["customer id missing in stripe payload"]}
        end
      else
          Rails.logger.debug( "------ >>>>>>>>  no payment_intent.requires_action', 'charge.failed' events  <<<<<<<< ------- ")
        render json: {"status": "failed", errors: ["uncaptured stripe event #{event_type}"]}
      end
    end
    
    def test_api
      # out_hash = Hash.from_xml(request.body.read.gsub("\n", "").gsub("\n", ""))
      # puts out_hash

      # binding.pry

      payload = request.body.read
      payld_data = JSON.parse(payload, symbolize_names: true)
      payld_event = Stripe::Event.construct_from(payld_data)

      # Get the type of webhook event sent - used to check the status of PaymentIntents.
      event_type = payld_event['type']
      data = payld_event['data']
      data_object = data['object']

      Rails.logger.debug( "------ >>>>>>>> - Test API - <<<<<<<< ------- ")
      Rails.logger.debug( event_type)
      # Rails.logger.debug( data_object)

      if ['payment_intent.requires_action', 'charge.failed'].include?(event_type)
        # check for stripe customer id from the payload
        if payld_data[:data] && payld_data[:data][:object] && payld_data[:data][:object][:customer]
          
          customer_id = payld_data[:data][:object][:customer]
          Rails.logger.debug( "------ >>>>>>>>  customer_id  <<<<<<<< ------- #{customer_id}")
          # customer = ClientUser.find_by_stripe_token(customer_id)

          # GeneralServices.new(customer.id, nil).downgrade_plan

          render json: {"status": "success"}
        else
          Rails.logger.debug( "------ >>>>>>>>  error on payld_data  <<<<<<<< -------")

          render json: {"status": "failed", errors: ["customer id missing in stripe payload"]}
        end
      else
        Rails.logger.debug( "------ >>>>>>>>  no payment_intent.requires_action', 'charge.failed' events  <<<<<<<< ------- ")

        render json: {"status": "failed", errors: ["uncaptured stripe event #{event_type}"]}
      end

      # puts event_type
      # puts data_object


      if event_type == 'customer.created'
        Rails.logger.debug("------- customer.created --------- ")
        Rails.logger.debug(data_object)
      end

      if event_type == 'customer.updated'
        Rails.logger.debug("------ customer.updated ------------>>> ")
        Rails.logger.debug(data_object)
        # puts data_object
      end




      if event_type == 'invoice.upcoming'
        Rails.logger.debug("------ invoice.upcoming ------------>>> ")
        Rails.logger.debug(data_object)
        # puts data_object
      end

      if event_type == 'invoice.paid'
        Rails.logger.debug("------ invoice.paid ------------>>> ")
        Rails.logger.debug(data_object)
      end

      if event_type == 'invoice.created'
        Rails.logger.debug("------ invoice.created ------------>>> ")
        Rails.logger.debug(data_object)
        # puts data_object
      end

      if event_type == 'invoice.finalized'
        Rails.logger.debug("------ invoice.finalized ------------>>> ")
        Rails.logger.debug(data_object)
        # puts data_object
      end

      if event_type == 'invoice.payment_succeeded'
        Rails.logger.debug("------ invoice.payment_succeeded ------------>>> ")
        Rails.logger.debug(data_object)
        # puts data_object
      end

      if event_type == 'invoice.payment_failed'
        Rails.logger.debug("------ invoice.payment_failed ------------>>> ")
        Rails.logger.debug(data_object)
        # puts data_object
      end

      if event_type == 'invoice.upcoming'
        Rails.logger.debug("------ invoice.upcoming ------------>>> ")
        Rails.logger.debug(data_object)
      end




      if event_type == 'charge.captured'
        Rails.logger.debug("------ Charge captured ------------>>> ")
        Rails.logger.debug(data_object)
      end

      if event_type == 'charge.expired'
        Rails.logger.debug("------ Charge expired ------------>>> ")
        Rails.logger.debug(data_object)
      end

      if event_type == 'charge.updated'
        Rails.logger.debug("------ Charge updated ------------>>> ")
        Rails.logger.debug(data_object)
      end

      if event_type == 'charge.refunded'
        Rails.logger.debug("------ Charge refunded ------------>>> ")
        Rails.logger.debug(data_object)
      end

      if event_type == 'charge.succeeded'
        Rails.logger.debug("------ Charge succeeded ------------>>> ")
        Rails.logger.debug(data_object)
      end

      if event_type == 'charge.pending'
        Rails.logger.debug("------ Charge Pending ------------>>> ")
        Rails.logger.debug(data_object)
      end

      if event_type == 'charge.failed'
        Rails.logger.debug("------ Charge Failed ------------>>> ")
        Rails.logger.debug(data_object)
      end




      if event_type == 'payment_intent.succeeded'
        Rails.logger.debug("------ payment_intent.succeeded ------------>>> ")
        Rails.logger.debug(data_object)
        # puts data_object
      end




      if event_type == 'setup_intent.succeeded'
        Rails.logger.debug("------ setup_intent.succeeded ------------>>> ")
        Rails.logger.debug(data_object)
      end

      if event_type == 'setup_intent.created'
        Rails.logger.debug("------ setup_intent.created ------------>>> ")
        Rails.logger.debug(data_object)
      end

      if event_type == 'customer.subscription.created'
        Rails.logger.debug("------ customer.subscription.created ------------>>> ")
        Rails.logger.debug(data_object)
        # puts data_object
      end

      render json: {"status": "success"}
    end


    


  end
end

# http://demo.itslabel.me/api/test_api
# http://demo.itslabel.me/api/api_downgrade