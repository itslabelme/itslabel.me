class CreateTranslations < ActiveRecord::Migration[5.2]
  def change
    create_table :translations do |t|

      t.string :input_phrase, limit: 256, null: false
      #t.string :input_description, limit: 1024, null: true
      t.string :input_language, limit: 16, null: false
      
      t.string :output_phrase, limit: 256, null: false
      #t.string :output_description, limit: 1024, null: true
      t.string :output_language, limit: 16, null: false

      t.string :category, limit: 16, null: true
      t.references :admin_user
      t.string :status, default: "PENDING", limit: 16, null: false

      t.timestamps null: false

    end
  end
end
