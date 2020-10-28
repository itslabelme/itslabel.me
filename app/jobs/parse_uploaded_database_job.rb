class ParseUploadedDatabaseJob < ApplicationJob
  queue_as :default

  def perform(csv_file_path, current_admin_user, upload_history_id)
    Translation.import_data_from_csv(csv_file_path, current_admin_user, upload_history_id)
  end
end
