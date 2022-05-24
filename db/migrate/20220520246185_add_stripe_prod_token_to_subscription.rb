class AddStripeProdTokenToSubscription < ActiveRecord::Migration[5.2]
  def change
    add_column :subscriptions, :stripe_subscr_token, :string
  end
end
