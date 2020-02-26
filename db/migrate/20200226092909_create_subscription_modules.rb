class CreateSubscriptionModules < ActiveRecord::Migration[5.2]
  def change
    create_table :subscription_modules do |t|
      t.string :title, limit: 256, null: false
      t.string :controller, limit: 256, null: false
      t.string :action, limit: 256, null: false
      t.references :subscription, index: true, foreign_key: {to_table: :subscriptions, on_delete: :cascade}
      t.timestamps
    end
  end
end
