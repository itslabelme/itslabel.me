class TranslationRequest < ApplicationRecord

  # Includes
  include Itslabel::Status::DocumentStatus
  include Itslabel::Scopes::TranslationRequestScopes
  include Itslabel::Permissions::TranslationRequestPermissions

  # Validations
  validates :input_phrase, presence: true, length: {maximum: 256}, allow_blank: false
  validates :input_language, presence: true
  validates :output_phrase, length: {maximum: 256}, allow_blank: true
  validates :output_language, presence: true
  validates :doc_type, presence: false

  # Associations
  belongs_to :requested_by, class_name: "ClientUser", optional: true
  
  # ----------------
  # Instance Methods
  # ----------------

  def display_requested_user_name
    requested_by.display_name
  end
  
end