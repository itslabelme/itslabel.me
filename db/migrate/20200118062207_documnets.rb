class Documnets < ActiveRecord::Migration[5.2]
  def change
    create_table :documents do |t|
      t.string :name,              limit: 256, null: false
      t.references :user, foreign_key: { to_table: :client_users }, index: true
      t.string   :documnet_type,    limit: 256
      t.datetime :created_at
      t.datetime :updated_at
      t.timestamps null: false
    end
    
  end
end
