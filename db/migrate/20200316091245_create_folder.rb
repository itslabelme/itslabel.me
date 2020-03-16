class CreateFolder < ActiveRecord::Migration[5.2]
  def change
    create_table :folders do |t|
      t.string :title, limit: 256, null: false
      t.bigint :parent_id
      t.timestamps null: false
    end
  end
end
