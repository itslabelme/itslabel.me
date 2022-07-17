
Rails.configuration.stripe = {
  publishable_key: Rails.application.secrets.stripe_publishable_key,
  secret_key: Rails.application.secrets.stripe_secret_key,
  stripe_price_token_premium: Rails.application.secrets.stripe_price_token_premium,
  stripe_price_token_monthly: Rails.application.secrets.stripe_price_token_monthly,
  stripe_price_token_3_month: Rails.application.secrets.stripe_price_token_3_month,
  stripe_price_token_6_month: Rails.application.secrets.stripe_price_token_6_month,
  stripe_price_token_12_month: Rails.application.secrets.stripe_price_token_12_month
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]