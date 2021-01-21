class AddFieldsToUploadSummaries < ActiveRecord::Migration[5.2]
  def change
    add_column :uploads_summaries, :total_inserted_data, :integer
    add_column :uploads_summaries, :total_existing_data, :integer
    add_column :uploads_summaries, :total_error_data, :integer
  end
end
