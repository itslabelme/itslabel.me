class CreateTemplateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :template_tags do |t|
      t.references :document, index: true,foreign_key: {to_table: :documents, on_delete: :cascade}
      t.string :source_langage, limit: 256, null: false
      t.string :output_language, limit: 256
      t.string :input_phrase, limit: 256
      t.string :output_phrase , limit: 256
      t.string :source_langage, limit: 256, null: false
      t.string :output_language, limit: 256
      t.string :input_phrase, limit: 256
      t.string :phrase_group, limit: 256
      t.string :ingradiant_weight, limit: 256
      t.string :ingradiant_percentage, limit: 256
      t.string :footer_text , limit: 1024
      t.string :tags , limit: 1024
    end
  end
end
