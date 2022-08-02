class GeneralServices

  def initialize(user, subscription_id)
    @user = user
    @subscription_id = subscription_id
    # @stripe_price_token = Rails.configuration.stripe[:stripe_price_token]
  end

  def downgrade_plan
    user_subscription = UserSubscription.find_by(user_id: @user)
    free_subscription = Subscription.find_by_title("Free")

    if @subscription_id
      user_subscription.subscription_id = @subscription_id
    else
      user_subscription.subscription_id = free_subscription.id
    end

    if user_subscription.valid?
      user_subscription.save
    end

  end

end