class CreateClientsFeedbacks < ActiveRecord::Migration[5.2]
  def change
    create_table :clients_feedbacks do |t|
      t.string :name, limit: 256, null: false
      t.string :type    
      t.text :input, null: false
      t.text :output, null: false
      t.string :remarks, null: true
      t.timestamps 
    end
  end
end
