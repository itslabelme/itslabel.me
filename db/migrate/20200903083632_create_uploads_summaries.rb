class CreateUploadsSummaries < ActiveRecord::Migration[5.2]
  def change
    create_table :uploads_summaries do |t|
      # t.references :uploads_history, foreign_key: true
      t.integer :translation_uploads_history_id, null: false
      # t.json :summary, null: false, default: "{}" not sure if this is defauted like this - to be researched
      t.json :summary_new, null: false
      t.timestamps null: false
    end
  end
end
