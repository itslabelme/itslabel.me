class Tags < ActiveRecord::Migration[5.2]
  def change
     create_table :tags do |t|
      t.string   :label_eng,              limit: 256, null: false
      t.string   :label_french,           limit: 256
      t.string   :label_arbi,             limit: 256
      t.string   :label_russian,          limit: 256
      t.string   :ingradiant_value,       limit: 256
      t.string   :daily_value,            limit: 256
      t.datetime :created_at
      t.datetime :updated_at
      t.timestamps null: false
    end
    
  end
end
