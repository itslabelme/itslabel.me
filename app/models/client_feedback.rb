class ClientFeedback < ApplicationRecord

  # Validations
  validates :client_user_id, presence: true
  validates :category, presence: true
  validates :input, presence: true
  validates :output, presence: true
  validates :remarks, presence: false
  validates :input_language, presence: true
  validates :output_language, presence: true
  
  # Associations
  belongs_to :client_user, class_name: "ClientUser", foreign_key: :client_user_id

  # ----------------
  # Instance Methods
  # ----------------
  
  def display_name
    client_user.display_name
  end
end
