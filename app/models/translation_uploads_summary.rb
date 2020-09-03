class TranslationUploadsSummary < ApplicationRecord
  validates :translation_uploads_history_id, presence: true
  validates :summary, presence: true
 end