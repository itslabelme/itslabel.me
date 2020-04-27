class CreateAdditionalFieldToLabelTemplate < ActiveRecord::Migration[5.2]
  def change
     add_column :label_templates, :status, :string, default: "ACTIVE", limit: 16, null: false
  end
end
