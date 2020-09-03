class CreateTranslationUploadsSummaries < ActiveRecord::Migration[5.2]
  def change
    create_table :translation_uploads_summaries do |t|
      t.integer :translation_uploads_history_id, null: false
      t.string :summary, null: false
      t.timestamps null: false
    end
  end
end
