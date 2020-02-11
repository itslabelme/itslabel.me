class CreateNutritionDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :nutrition_documents do |t|
      
      t.string :title, limit: 256
      t.string :sub_title, limit: 256

      t.string :input_langage, limit: 256, null: false
      t.string :output_language, limit: 256, null: false

      t.integer :total_weight
      t.integer :total_quantity
      t.integer :serving_size
      t.integer :no_of_servings
      t.integer :total_calories

      t.string :footer , limit: 1024
      t.timestamps null: false
    end

    create_table :nutrition_facts_documents_tags, id: false do |t|
      t.belongs_to :nutrition_document
      t.belongs_to :tag
    end

    create_table :nutrition_document_items do |t| # only for nutrition document
      
      t.belongs_to :nutrition_document

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
