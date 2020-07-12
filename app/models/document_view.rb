class DocumentView < ApplicationRecord

  # Constants
  LANGUAGES = ["ENGLISH", "ARABIC", "FRENCH"].freeze
  LANGUAGE_CODES = {"ENGLISH" => "EN", "ARABIC" => "AR", "FRENCH" => "FR"}.freeze

  # Set Table Name
  self.table_name = "documents_view"

  
  # Includes
  include Itslabel::Status::DocumentStatus
  include Itslabel::Scopes::DocumentScopes
  include Itslabel::Permissions::DocumentPermissions

  # Callbacks
  before_destroy { raise(ActiveRecord::ReadOnlyRecord) }
  
  # Associations
  belongs_to :template, class_name: "LabelTemplate"
  belongs_to :user, class_name: "User"
  belongs_to :folders, class_name: "DocumentFolder"
  


  # -----------------
  # Instance Methods
  # -----------------

  def readonly() true end

  def to_param
    "#{id}-#{title}".parameterize[0..32]
  end
  
  def display_name
    self.title
  end

  def display_type
    "Table Mode"
  end

  def display_icon
    case self.doc_type
    when "table_document"
      "icon-grid"
    when "template_document"
      "icon-folder"
    when "nutrition_fact_document"
      "icon-square"
    when "freestyle_document"
      "icon-file"
    else
      "icon-file"
    end
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