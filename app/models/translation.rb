require 'csv'

class Translation < ApplicationRecord

  # Constants
  LANGUAGES = ["ENGLISH", "ARABIC", "FRENCH"].freeze

  # Set Table Name
  self.table_name = "translations"


  class << self
    attr_accessor :csv_upload_summary
  end

  # Imports
  extend Importer
  extend Itslabel::Uploads::TranslationUploads

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

  # Associations
  belongs_to :admin_user, class_name: "AdminUser", optional: true

  # Callbacks
  before_save :sanitize_phrases


  
  # ----------------
  # Instance Methods
  # ----------------

  def display_name
    "#{input_phrase} - #{output_phrase}"
  end
  
end