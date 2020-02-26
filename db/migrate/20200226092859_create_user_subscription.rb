class CreateUserSubscription < ActiveRecord::Migration[5.2]
  def change
    create_table :user_subscriptions do |t|
      t.references :user, index: true, foreign_key: {to_table: :client_users, on_delete: :cascade}
      t.references :subscription, index: true, foreign_key: {to_table: :subscriptions, on_delete: :cascade}
      t.timestamps
    end
  end
end
