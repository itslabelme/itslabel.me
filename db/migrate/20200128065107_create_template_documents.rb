class CreateTemplateDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :template_documents do |t|
      t.string :title, limit: 256, null: false
      
      t.string :input_language, limit: 16, null: false
      t.string :output_language, limit: 16, null: false

      t.string :status, default: "ACTIVE", limit: 16, null: false
      # t.references :folder, index: true,null:true, foreign_key: {to_table: :document_folders, on_delete: :nullify} # Commented by sanoop @ 7/6/2020, got error by using this foreign also this filed is not used 
      t.text :input_html_source
      t.text :output_html_source

      t.boolean :favorite, default: false
      
      t.references :template, index: true
      t.references :user, index: true, foreign_key: {to_table: :client_users, on_delete: :cascade}
      t.timestamps null: false
    end

    

  end
end
