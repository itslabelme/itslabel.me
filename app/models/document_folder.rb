class DocumentFolder < ApplicationRecord

  has_ancestry
  
  # Validations
  validates :title, length: {maximum: 256}, allow_blank: false
  validates :title, uniqueness: { scope: :user_id }

  # Associations
  has_many :documents, class_name: "DocumentView", foreign_key: :folder_id
  belongs_to :client_user, foreign_key: :user_id

end