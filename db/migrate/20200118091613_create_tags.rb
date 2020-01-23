class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.string :name, limit: 256, null: false
      t.timestamps null: false
    end
  end
end
