class AddUserSubStripeTokenToUserSubscription < ActiveRecord::Migration[5.2]
  def change
    add_column :user_subscriptions, :usr_subscr_strip_token, :string
  end
end
