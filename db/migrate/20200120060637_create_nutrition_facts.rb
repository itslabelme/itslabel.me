class CreateNutritionFacts < ActiveRecord::Migration[5.2]
  def change
    create_table :nutrition_facts do |t|
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

    create_table :nutrition_facts_tags, id: false do |t|
      t.belongs_to :nutrition_fact
      t.belongs_to :tag
    end
  end
end
