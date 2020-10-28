class CreateUploadsHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :uploads_histories do |t|
      # t.references :admin_user, foreign_key: true
      t.string :admin_user, limit: 256, null: false
      # t.string :file_path, limit: 1024, null: false
      t.string :file_path, limit: 256, null: false
      t.timestamps null: false
    end
  end
end
