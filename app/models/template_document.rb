class TemplateDocument < ApplicationRecord
   
  # Constants
  LANGUAGES = ["ENGLISH", "ARABIC", "FRENCH"].freeze
  LANGUAGE_CODES = {"ENGLISH" => "EN", "ARABIC" => "AR", "FRENCH" => "FR"}.freeze

  # Set Table Name
  self.table_name = "template_documents"

  attr_accessor :skip_callback

  # Includes
  include Itslabel::Status::DocumentStatus
  include Itslabel::Permissions::DocumentPermissions
  include Itslabel::Scopes::TemplateDocumentScopes
  include Itslabel::Callbacks::TemplateDocumentCallbacks

  # Validations
  validates :title, presence: true, length: {maximum: 256}
  # validates :description, length: {maximum: 1024}, allow_blank: true, presence: true
  
  validates :input_language, presence: true, :inclusion => {:in => LANGUAGES, :message => "is not a valid language" }
  validates :output_language, presence: true, :inclusion => {:in => LANGUAGES, :message => "is not a valid language" }

  # Associations
  belongs_to :user, class_name: "ClientUser"
  belongs_to :template, class_name: "LabelTemplate", optional: true
  belongs_to :folder, class_name: "DocumentFolder", optional: true, foreign_key: :folder_id
  
  # Callbacks
  before_save :translate, unless: :skip_callback

  # ----------------
  # Instance Methods
  # ----------------

  def to_param
    "#{id}-#{title}".parameterize[0..32]
  end
  
  def display_name
    self.title
  end

  def display_type
    "Template"
  end

  def display_template
    template.try(:name)
  end

  def display_input_language
    LANGUAGE_CODES[self.input_language] if self.input_language
  end

  def display_output_language
    LANGUAGE_CODES[self.output_language] if self.output_language
  end

end
