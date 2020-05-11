class CreateDocumentFolder < ActiveRecord::Migration[5.2]
  def change
    create_table :document_folders do |t|
      t.string :title, limit: 256, null: false
      t.bigint :parent_id
      t.references :user
      t.timestamps null: false
    end
    #add_column :table_documents, :folder_id, :integer
    #add_column :template_documents, :folder_id, :integer
  end
end
