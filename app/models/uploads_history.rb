class UploadsHistory < ApplicationRecord
  
  # Validations
  validates :admin_user, presence: true
  validates :file_path, presence: true

  # Associations
  # has_many :upload_summaries, class_name: "UploadSummary", foreign_key: :upload_history_id
  
 end