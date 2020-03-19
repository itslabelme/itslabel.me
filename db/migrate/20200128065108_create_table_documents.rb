class CreateTableDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :table_documents do |t|
      t.string :title, limit: 256, null: false
      
      t.string :input_language, limit: 16, null: false
      t.string :output_1_language, limit: 16, null: false
      t.string :output_2_language, limit: 16, null: true
      t.string :output_3_language, limit: 16, null: true
      t.string :output_4_language, limit: 16, null: true
      t.string :output_5_language, limit: 16, null: true

      t.string :status, default: "ACTIVE", limit: 16, null: false
      t.boolean :favorite, default: false
      t.references :folder, index: true,null:true, foreign_key: {to_table: :folders, on_delete: :nullify}
      t.references :user, index: true, foreign_key: {to_table: :client_users, on_delete: :cascade}
      t.timestamps null: false
    end

    create_table :table_document_items do |t| # only table based 
      
      t.belongs_to :table_document

      t.string :input_phrase, limit: 256, null: false
      t.string :input_language, limit: 16, null: false
      
      t.string :output_1_phrase, limit: 256, null: true
      t.string :output_1_language, limit: 16, null: true
      t.belongs_to :output_1_translation

      t.string :output_2_phrase, limit: 256, null: true
      t.string :output_2_language, limit: 16, null: true
      t.belongs_to :output_2_translation

      t.string :output_3_phrase, limit: 256, null: true
      t.string :output_3_language, limit: 16, null: true
      t.belongs_to :output_3_translation

      t.string :output_4_phrase, limit: 256, null: true
      t.string :output_4_language, limit: 16, null: true
      t.belongs_to :output_4_translation

      t.string :output_5_phrase, limit: 256, null: true
      t.string :output_5_language, limit: 16, null: true
      t.belongs_to :output_5_translation

      t.boolean :translated, default: false
      
      t.timestamps null: false
    end

  end
end
