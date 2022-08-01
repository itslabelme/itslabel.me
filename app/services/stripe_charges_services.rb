class StripeChargesServices
  DEFAULT_CURRENCY = 'inr'.freeze
  
  # What We do For subscription
    # 1. Create product in stripe by manualy with specifing price
    # 2. Keep the "Price App Id" in our secret.yml file to refer while subscription
    # 3. By calling 'susbscribe' function for subscription
    # 4. In 'susbscribe' function fetch the 'App Id' from yml file based on his selection
    # 5. Check user is already created(If the user created then stripe token saved in user table), else create new user and save stripe token
    # 6. Using costomer token, price token and trial period create subscription



  def initialize(params, user, subscription_id)
    @stripe_email = params[:stripeEmail]
    @stripe_token = params[:stripeToken]
    @subscription_id = subscription_id
    # @stripe_price_token = Rails.configuration.stripe[:stripe_price_token]
    @user = user
  end

  def susbscribe

    #Function to create subscription using user(for strip_user_token) object and subscription(for price token) object
    # sub = Subscription.find_by_title("Premium")
    sub = Subscription.find_by_id(@subscription_id)

    if sub.title == "Monthly"
      stripe_price_token = Rails.configuration.stripe[:stripe_price_token_monthly]
    elsif sub.title == "3 Months"
      stripe_price_token = Rails.configuration.stripe[:stripe_price_token_3_month]
    elsif sub.title == "6 Months"
      stripe_price_token = Rails.configuration.stripe[:stripe_price_token_6_month]
    elsif sub.title =="12 Months"
      stripe_price_token = Rails.configuration.stripe[:stripe_price_token_12_month]
    end

    customer_data = find_customer
    if customer_data[:status] == 200
      # binding.pry

      subscription_data = create_subscription(sub, customer_data[:data], stripe_price_token)
      if subscription_data[:status] == 200
        return subscription_data
      else
        return subscription_data
      end
    else
      return customer_data
    end
  end

  def delete_subscription
    user_subscription = UserSubscription.find_by(user_id: @user.id)

    # binding.pry
    
    Stripe::Subscription.delete(
      user_subscription.usr_subscr_strip_token,
      # 'sub_1JbjFX2eZvKYlo2CQdChmkpk',
    )
  end

  private

  attr_accessor :user, :stripe_email, :stripe_token, :order

  def find_customer
    if user.stripe_token
      # binding.pry 
      customer_data = retrieve_customer(user.stripe_token)
      return {status: 200, data: customer_data, message: "Successfully Credited" }
    else
      create_customer
    end
  end

  def retrieve_customer(stripe_token)
    Stripe::Customer.retrieve(stripe_token) 
  end


  def create_customer
    begin
      customer = Stripe::Customer.create(
        name: "#{@user.first_name} #{@user.last_name}",
        email: @user.email,
        source: stripe_token,
        address: {
          line1: "#{@user.organisation},#{@user.country}",
          city: "#{@user.country}",
          country: 'US',
          # postal_code: '683578',
          # state: 'Kerala',
        },
      )
      # binding.pry
    rescue Stripe::CardError => e 
      # e.error.message
      return {status: 400, data: customer, message: e.error.message }
    rescue Stripe::RateLimitError => e
      return {status: 400, data: customer, message: e.error.message }
    rescue Stripe::InvalidRequestError => e
      return {status: 400, data: customer, message: e.error.message }
    rescue Stripe::AuthenticationError => e
      return {status: 400, data: customer, message: e.error.message }
    rescue Stripe::APIConnectionError => e
      return {status: 400, data: customer, message: e.error.message }
    rescue Stripe::StripeError => e
      return {status: 400, data: customer, message: e.error.message }
    rescue => e
      return {status: 400, data: customer, message: e.error.message }
    else
      if customer
        @user.update(stripe_token: customer.id)
        return {status: 200, data: customer, message: "Successfully Credited" }
      end
    end


  end


  def create_subscription(subscription, customer, stripe_price_token)
    traila_time = Time.now + 7.days
    # traila_time = Time.now + (5 * 60) # 10 minit + time stamp
    traila_time_stamp = traila_time.to_i

    begin
      strip_sub = Stripe::Subscription.create({
        customer: customer.id,
        items: [
          {
            price: stripe_price_token,
          },
        ],
        trial_end: traila_time_stamp


      })

    # binding.pry 
    rescue Stripe::CardError => e 
      # e.error.message
      return {status: 400, data: strip_sub, message: e.error.message }
    rescue Stripe::RateLimitError => e
      return {status: 400, data: strip_sub, message: e.error.message }
    rescue Stripe::InvalidRequestError => e
      return {status: 400, data: strip_sub, message: e.error.message }
    rescue Stripe::AuthenticationError => e
      return {status: 400, data: strip_sub, message: e.error.message }
    rescue Stripe::APIConnectionError => e
      return {status: 400, data: strip_sub, message: e.error.message }
    rescue Stripe::StripeError => e
      return {status: 400, data: strip_sub, message: e.error.message }
    rescue => e
      return {status: 400, data: strip_sub, message: e.error.message }
    else
      return {status: 200, data: strip_sub, message: "Successfully Subscribed" }
    end

    # return strip_sub
    # user_subs = UserSubscription.where(user_id: customer.id, subscription_id: subscription.id).first
    # user_subs.update(usr_subscr_strip_token: strip_sub.id)

  end








  #Function to Create product or services
  def create_product
    product = Stripe::Product.create(
      {
        name: 'Premium',
        description: "Premium plan"

      })
    sub = Subscription.find_by_title("Premium")
    sub.update(stripe_prod_token: product.id)
  end

  # Function to retrive product
  def retrive_product(stripe_prod_token)
    ret_prod = Stripe::Product.retrieve(stripe_prod_token)
    binding.pry
  end

  # function to create plan
  def create_plan(stripe_prod_token)
    Stripe::Plan.create({
      amount: 500,
      currency: 'usd',
      interval: 'month',
      product: stripe_prod_token,
    })
  end

  #  Function to get plan
  def list_plan
    all_plans = Stripe::Plan.list({limit: 5})
    # all_plans.data   #gives the json objects of all plan data
    # all_plans.data[0].id   #gives first plan id example:- "plan_LiqWnNsQTvZ9vz"
    # binding.pry 
  end

  # Function to creta e retrive plan
  def retrieve_plan(plan_id)
    selected_plan = Stripe::Plan.retrieve(
      plan_id
    ) 
    selected_plan
    # binding.pry 
  end

  # Function to create price
  def create_price(sub_obj)
    price = Stripe::Price.create({
      unit_amount: 500,
      currency: 'usd',
      recurring: {interval: 'month'},
      product: sub_obj.stripe_prod_token,
    })
    # binding.pry 
    sub_obj.update(stripe_price_token: price.id)
  end


end