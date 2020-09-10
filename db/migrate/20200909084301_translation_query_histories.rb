class TranslationQueryHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :translation_query_histories do |t|

      t.text :input_phrase, null: false
      t.string :input_language, limit: 16, null: false
      
      t.text :output_phrase, null: false
      t.string :output_language, limit: 16, null: false

      t.boolean :error, default: false
      t.json :error_message, null: true

      t.references :client_user
      t.string :doc_type, limit: 256, null: true

      t.string :status, default: "ACTIVE", limit: 16, null: false

      t.timestamps null: false

    end
  end
end
