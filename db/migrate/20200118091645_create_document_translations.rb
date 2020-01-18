class CreateDocumentTranslations < ActiveRecord::Migration[5.2]
  def change
    create_table :document_translations do |t|

      t.timestamps
    end
  end
end
