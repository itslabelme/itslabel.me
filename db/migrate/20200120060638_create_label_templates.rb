class CreateLabelTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :label_templates do |t|
      t.string :name, limit: 256
      t.string :description, limit: 1024

      t.string :style, limit: 64

      t.text :ltr_html_source
      t.text :rtl_html_source

      t.boolean :latest, default: true
      
      t.references :admin_user, index: true, foreign_key: {to_table: :admin_users}

      t.timestamps null: false
    end
  end
end
