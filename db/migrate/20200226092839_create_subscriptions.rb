class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.string :title, limit: 256, null: false
      t.integer :price, default: 0, null: false
      t.string :status, default: "ACTIVE", limit: 16, null: false
      t.timestamps 
    end
  end
end
