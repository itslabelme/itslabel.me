class Translation < ApplicationRecord

  # Constants
  LANGUAGES = ["ENGLISH", "ARABIC", "FRENCH"].freeze

  # Set Table Name
  self.table_name = "translations"

  # Imports
  extend Importer

  # Includes
  include Itslabel::Status::TranslationStatus
  include Itslabel::Scopes::TranslationScopes
  include Itslabel::Permissions::TranslationPermissions
  include Itslabel::Validations::TranslationValidations
  include Itslabel::Callbacks::TranslationCallbacks
  include Itslabel::Imports::TranslationImports
  include Itslabel::TranslationMethods
  
  # Validations
  validates :english_phrase, presence: true, length: {maximum: 256}, allow_blank: false
  
  validates :arabic_phrase, presence: true, length: {maximum: 256}, allow_blank: false
  validates :french_phrase, presence: true, length: {maximum: 256}, allow_blank: false
  # Associations
  belongs_to :admin_user, class_name: "AdminUser", optional: true

  # Callbacks
  before_save :sanitize_phrases


  
  # Generic Methods
  # ---------------
  def display_name
    #{}"#{input_phrase} - #{output_phrase}"
  end
  
  
end