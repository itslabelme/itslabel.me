class CreateDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :documents do |t|
      t.string :title, limit: 256, null: false
      t.string :description, limit: 1024
      
      t.string :input_language, limit: 16, null: false
      t.string :output_1_language, limit: 16, null: false
      t.string :output_2_language, limit: 16, null: true
      t.string :output_3_language, limit: 16, null: true
      t.string :output_4_language, limit: 16, null: true
      t.string :output_5_language, limit: 16, null: true

      t.string :status, default: "ACTIVE", limit: 16, null: false

      # Single Table Inheritance
      t.string :type, limit: 128 # should be 'table_based' or 'template_based' 

      t.text :input_html_source
      t.text :output_html_source
      
      t.references :template, index: true
      t.references :user, index: true, foreign_key: {to_table: :client_users, on_delete: :cascade}
      t.timestamps null: false
    end

    create_table :documents_tags, id: false do |t|
      t.belongs_to :document
      t.belongs_to :tag
    end

    create_table :document_items do |t| # only table based 
      
      t.belongs_to :document

      t.string :input_phrase, limit: 256, null: false
      t.string :input_language, limit: 16, null: false
      
      t.string :output_1_phrase, limit: 256, null: true
      t.string :output_1_language, limit: 16, null: true

      t.string :output_2_phrase, limit: 256, null: true
      t.string :output_2_language, limit: 16, null: true

      t.string :output_3_phrase, limit: 256, null: true
      t.string :output_3_language, limit: 16, null: true

      t.string :output_4_phrase, limit: 256, null: true
      t.string :output_4_language, limit: 16, null: true

      t.string :output_5_phrase, limit: 256, null: true
      t.string :output_5_language, limit: 16, null: true

      t.boolean :translated, default: false
      t.belongs_to :translation
      
      t.timestamps null: false
    end

  end
end
