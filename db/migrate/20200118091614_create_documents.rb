class CreateDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :documents do |t|
      t.references :user, index: true, foreign_key: {to_table: :client_users, on_delete: :cascade}
      t.string :name, limit: 256, null: false
      t.string :type, limit: 128 # should be 'table_based' or 'template_based' 
      t.timestamps null: false
    end
  end
end
