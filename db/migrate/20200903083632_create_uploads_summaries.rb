class CreateUploadsSummaries < ActiveRecord::Migration[5.2]
  def change
    create_table :uploads_summaries do |t|
      t.integer :translation_uploads_history_id, null: false
      t.json :summary_new,null: false
      t.timestamps null: false
    end
  end
end
