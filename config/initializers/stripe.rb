
Rails.configuration.stripe = {
  publishable_key: Rails.application.secrets.stripe_publishable_key,
  secret_key: Rails.application.secrets.stripe_secret_key,
  stripe_price_token: Rails.application.secrets.stripe_price_token
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]