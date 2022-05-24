module User
  class ChargesController < User::BaseController

    before_action :authenticate_client_user!

    rescue_from Stripe::CardError, with: :catch_exception

    def index
    end

    def new
    end

    def create

      StripeChargesServices.new(charges_params, @current_client_user).susbscribe
      
    end

    private

    def charges_params
      params.permit(:stripeEmail, :stripeToken, :order_id)
    end

    def catch_exception(exception)
      flash[:error] = exception.message
    end


  end
end
