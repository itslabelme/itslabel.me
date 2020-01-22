class Translation < ApplicationRecord

  # Set Table Name
  self.table_name = "translations"
  LANGUAGES = ["ENGLISH", "ARABIC", "FRENCH"].freeze

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
  validates :input_phrase, presence: true, length: {maximum: 256}, allow_blank: false
  validates :input_language, presence: true, :inclusion => {:in => LANGUAGES, :message => "is not a valid language" }
  validates :output_phrase, presence: true, length: {maximum: 256}, allow_blank: false
  validates :output_language, presence: true, :inclusion => {:in => LANGUAGES, :message => "is not a valid language" }

  validates :input_description, length: {maximum: 1024}, allow_blank: true
  validates :output_description, length: {maximum: 1024}, allow_blank: true
  
  # Associations
  belongs_to :admin_user, class_name: "AdminUser", optional: true

  # Callbacks
  before_save :sanitize_phrases


  
  # Generic Methods
  # ---------------
  def display_name
    "#{input_phrase} - #{output_phrase}"
  end
  
  
end