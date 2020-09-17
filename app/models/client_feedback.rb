class ClientFeedback < ApplicationRecord
  validates :client_user_id, presence: true
  validates :type, presence: false
  validates :input, presence: true
  validates :output, presence: true
  validates :remarks, presence: true
end
