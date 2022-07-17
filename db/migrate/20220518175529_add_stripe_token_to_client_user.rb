class AddStripeTokenToClientUser < ActiveRecord::Migration[5.2]
  def change
    add_column :client_users, :stripe_token, :string
  end
end
