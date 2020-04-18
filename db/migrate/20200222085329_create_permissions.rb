class CreatePermissions < ActiveRecord::Migration[5.2]
  def change
    create_table :permissions do |t|
      t.string :title, limit: 256, null: false
      t.string :route, :null => false, :limit=>256
      t.string :description, :null => false, :limit=>256
      t.string :permission_group, :null => true, :limit=>64
      t.timestamps null: false
    end
  end
end
