class CreateModules < ActiveRecord::Migration[5.2]
  def change
    create_table :modules do |t|
      t.string :title, limit: 256, null: false
      t.string :controller, limit:256,null:false
      t.string :action, limit:256,null:false
      t.string :route,  limit:256,null:false
      t.timestamps null: false
    end
  end
end
