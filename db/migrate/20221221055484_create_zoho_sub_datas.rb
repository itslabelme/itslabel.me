class CreateZohoSubDatas < ActiveRecord::Migration[5.2]
  def change
    create_table :zoho_sub_datas do |t|
      t.references :client_user
      t.string :zoho_customer_id, null: false   
      t.string :zoho_subscription_id, null: false   

      t.references :subscription, index: true, foreign_key: {to_table: :subscriptions, on_delete: :cascade}
      t.string :zoho_plan_code, null: false   

      t.string :status, default: "SUCCESS", limit: 16, null: false
      t.timestamps 
    end
  end
end
