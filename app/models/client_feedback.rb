class ClientFeedback < ApplicationRecord
  validates :client_user_id, presence: true
  validates :category, presence: true
  validates :input, presence: true
  validates :output, presence: true
  validates :remarks, presence: true
end
