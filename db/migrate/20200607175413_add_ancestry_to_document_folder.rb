class AddAncestryToDocumentFolder < ActiveRecord::Migration[5.2]
  def change
    add_column :document_folders, :ancestry, :string
    add_index :document_folders, :ancestry
  end
end
