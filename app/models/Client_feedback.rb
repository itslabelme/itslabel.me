class ClientsFeedback < ApplicationRecord
  validates :name, presence: true
  validates :type
  validates :input, presence: true
  validates :output, presence: true
  validates :remarks, presence: true

end
