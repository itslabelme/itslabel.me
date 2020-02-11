class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.string :name, limit: 256, null: false
      t.timestamps null: false
    end

    create_table :template_documents_tags, id: false do |t|
      t.references :document, polymorphic: true
      t.belongs_to :tag
    end

    create_table :table_documents_tags, id: false do |t|
      t.belongs_to :table_document
      t.belongs_to :tag
    end
  end
end
