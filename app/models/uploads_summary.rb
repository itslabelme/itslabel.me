class UploadsSummary < ApplicationRecord
  validates :translation_uploads_history_id, presence: true
  # validates :summary_new, presence: true
 end