module Api
  class UserSubscriptionsController < Api::BaseController
    skip_before_action :verify_authenticity_token
    


    def downgrading_api
      puts "<<<<<<<< === downgrading_api === >>>>>>>>>>>>"
      # user_id = params['subscription']['user_id']
      # GeneralServices.new(user_id, nil).downgrade_plan

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

      Rails.logger.debug( "------ >>>>>>>> - <<<<<<<< ------- ")
      Rails.logger.debug( event_type)
      # Rails.logger.debug( data_object)

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