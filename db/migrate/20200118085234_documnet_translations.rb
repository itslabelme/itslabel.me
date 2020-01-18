class DocumnetTranslations < ActiveRecord::Migration[5.2]
  def change
     create_table :document_trasnlations do |t|
      t.string :name,              limit: 256, null: false
      t.references :document, references: :document, index: true, null: false, foreign_key: {to_table: :documents, on_delete: :cascade}
      t.string   :row_heading,limit: 256, null: false
      t.references :tag, foreign_key: { to_table: :tags }, index: true
      t.datetime :created_at
      t.datetime :updated_at
      t.timestamps null: false
    end
        
  end
end
