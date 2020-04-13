class CreateSubscriptionPermissions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscription_permissions do |t|
      t.string :title, limit: 256, null: false
      t.references :permission, index: true, foreign_key: {to_table: :permissions, on_delete: :cascade}
      t.references :subscription, index: true, foreign_key: {to_table: :subscriptions, on_delete: :cascade}
      t.timestamps null: false
    end
  end
end
