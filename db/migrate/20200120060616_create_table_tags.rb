class CreateTableTags < ActiveRecord::Migration[5.2]
  def change
    create_table :table_tags do |t|
      t.references :document, index: true, foreign_key: {to_table: :documents, on_delete: :cascade}
      t.string :source_langage, limit: 256, null: false
      t.string :output_language, limit: 256
      t.string :input_phrase, limit: 256
      t.string :output_phrase , limit: 256
      t.timestamps null: false
    end
  end
end
