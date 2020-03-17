class CreateFolder < ActiveRecord::Migration[5.2]
  def change
    create_table :folders do |t|
      t.string :title, limit: 256, null: false
      t.bigint :parent_id
      t.references :user, index: true, foreign_key: {to_table: :client_users, on_delete: :cascade}
      t.timestamps null: false
    end
  end
end
