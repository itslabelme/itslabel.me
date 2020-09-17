class CreateClientFeedbacks < ActiveRecord::Migration[5.2]
  def change
    create_table :client_feedbacks do |t|
      t.references :client_user
      t.string :type, null: true    
      t.text :input, null: false
      t.text :output, null: false
      t.string :remarks, null: false
      t.timestamps 
    end
  end
end
