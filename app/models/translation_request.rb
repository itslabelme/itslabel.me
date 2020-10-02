class TranslationRequest < ApplicationRecord

  # Includes
  include Itslabel::Status::DocumentStatus
  include Itslabel::Scopes::TranslationQueryHistoryScopes
  include Itslabel::Permissions::TranslationQueryHistoryPermissions

  # Validations
  validates :requested_by_id, presence: true
  validates :input_phrase, presence: true, length: {maximum: 256}, allow_blank: false
  validates :input_language, presence: true
  validates :output_phrase, presence: true, length: {maximum: 256}, allow_blank: true
  validates :output_language, presence: true
  validates :doc_type, presence: true
  validates :status, presence: false

  # Associations
  belongs_to :requested_by, class_name: "ClientUser", optional: true
  
  # ----------------
  # Instance Methods
  # ----------------

   def display_name
    client_user.display_name
  end
  
end