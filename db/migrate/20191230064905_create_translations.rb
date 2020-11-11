class CreateTranslations < ActiveRecord::Migration[5.2]
  def change
    create_table :translations do |t|

      # t.string :english_phrase, limit: 256, null: false
      # t.string :arabic_phrase, limit: 256, null: false
      # t.string :french_phrase, limit: 256, null: false

      t.string :input_phrase, limit: 256, null: false
      t.string :input_language, limit: 16, null: false
      
      t.string :output_phrase, limit: 256, null: false
      t.string :output_language, limit: 16, null: false

      t.string :category, limit: 16, null: true
      t.references :admin_user
      t.string :status, default: "PENDING", limit: 16, null: false

      t.timestamps null: false

    end
  end
end
