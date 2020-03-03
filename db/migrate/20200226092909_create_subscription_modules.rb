class CreateSubscriptionModules < ActiveRecord::Migration[5.2]
  def change
    create_table :subscription_modules do |t|
      t.string :title, limit: 256, null: false
      t.references :modules, index: true, foreign_key: {to_table: :modules, on_delete: :cascade}
      t.references :subscription, index: true, foreign_key: {to_table: :subscriptions, on_delete: :cascade}
      t.timestamps null: false
    end
  end
end
