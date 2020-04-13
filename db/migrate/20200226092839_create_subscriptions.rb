class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.string :title, limit: 256, null: false
      t.float :price, default: 0, precision: 4, scale: 3, null: true
      t.string :status, default: "ACTIVE", limit: 16, null: false
      t.string :description, limit: 256, null: true
      t.timestamps 
    end
  end
end
