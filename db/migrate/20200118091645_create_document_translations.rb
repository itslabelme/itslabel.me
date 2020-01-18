class CreateDocumentTranslations < ActiveRecord::Migration[5.2]
  def change
    create_table :document_translations do |t|
      t.references :document, index: true
      t.references :tag, index: true
      t.string :name, limit: 256, null: false
      t.string :row_heading,limit: 256, null: false
      t.timestamps null: false
    end
  end
end
