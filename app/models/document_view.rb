class DocumentView < ApplicationRecord

  # Constants
  LANGUAGES = ["ENGLISH", "ARABIC", "FRENCH"].freeze
  LANGUAGE_CODES = {"ENGLISH" => "EN", "ARABIC" => "AR", "FRENCH" => "FR"}.freeze

  # Set Table Name
  self.table_name = "documents_view"

  def readonly() true end
  before_destroy { raise(ActiveRecord::ReadOnlyRecord) }
  

  include Itslabel::Status::DocumentStatus
  include Itslabel::Scopes::DocumentScopes
  include Itslabel::Permissions::DocumentPermissions


  # Associations
  belongs_to :template, class_name: "LabelTemplate"
  belongs_to :user, class_name: "User"
  
  
  


  # Scopes
  scope :optionals, lambda { where(optional: true) }
  scope :standards, lambda { where(optional: false) }
  scope :filter_by_project, lambda { |project_id| where(project_id: project_id) }
  scope :filter_by_costing_version, lambda { |costing_version_id| where(costing_version_id: costing_version_id) }
  



  

  # Generic Methods
  # ---------------
  def to_param
    "#{id}-#{title}".parameterize[0..32]
  end
  
  def display_name
    self.title
  end

  def display_type
    "Table Mode"
  end

  def display_input_language
    LANGUAGE_CODES[self.input_language] if self.input_language
  end

  def display_output_languages
    langs = []
    langs << LANGUAGE_CODES[self.output_1_language] if self.output_1_language
    langs << LANGUAGE_CODES[self.output_2_language] if self.output_2_language
    langs << LANGUAGE_CODES[self.output_3_language] if self.output_3_language
    langs << LANGUAGE_CODES[self.output_4_language] if self.output_4_language
    langs << LANGUAGE_CODES[self.output_5_language] if self.output_5_language
    langs
  end
  
end