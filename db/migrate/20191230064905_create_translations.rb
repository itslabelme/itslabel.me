class CreateTranslations < ActiveRecord::Migration[5.2]
  def change
    create_table :translations do |t|

      t.string :english_phrase, limit: 256, null: true
            
      t.string :arabic_phrase, limit: 256, null: true
      t.string :french_phrase, limit: 256, null: true
      t.string :category, limit: 16, null: true
      t.references :admin_user
      t.string :status, default: "PENDING", limit: 16, null: false

      t.timestamps null: false

    end
  end
end
