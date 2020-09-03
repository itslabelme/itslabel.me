class CreateTranslationUploadsHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :translation_uploads_histories do |t|
      t.string :admin_user, limit: 256, null: false
      t.string :file_path, limit: 256, null: false
      t.timestamps null: false
    end
  end
end
