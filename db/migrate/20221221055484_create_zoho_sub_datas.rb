class CreateZohoSubDatas < ActiveRecord::Migration[5.2]
  def change
    create_table :zoho_sub_datas do |t|
      t.references :client_user
      t.references :subscription, index: true, foreign_key: {to_table: :subscriptions, on_delete: :cascade}
      
      t.string :zoho_customer_id, null: true   
      t.string :zoho_subscription_id, null: true   
      t.string :zoho_plan_code, null: true   
      t.string :zoho_plan, null: true   

      t.string :status, default: "FREE", limit: 16, null: false # FREE, EXPIRED, LIVE & CANCELLED
      t.timestamps 
    end
  end
end
