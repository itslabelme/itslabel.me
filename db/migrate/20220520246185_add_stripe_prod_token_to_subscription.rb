class AddStripeProdTokenToSubscription < ActiveRecord::Migration[5.2]
  def change
    # add_column :subscriptions, :stripe_prod_token, :string
    # add_column :subscriptions, :stripe_price_token, :string
    add_column :subscriptions, :stripe_subscr_token, :string
  end
end
