class TableDocument < ApplicationRecord
   
  # Constants
  LANGUAGES = ["ENGLISH", "ARABIC", "FRENCH"].freeze
  LANGUAGE_CODES = {"ENGLISH" => "EN", "ARABIC" => "AR", "FRENCH" => "FR"}.freeze

  # Set Table Name
  self.table_name = "table_documents"

  # Includes
  include Itslabel::Status::DocumentStatus
  include Itslabel::Permissions::DocumentPermissions
  include Itslabel::Scopes::TableDocumentScopes
  # include Itslabel::Callbacks::TableDocumentCallbacks

  # Validations
  validates :title, presence: true, length: {maximum: 256}
  # validates :description, length: {maximum: 1024}, allow_blank: true, presence: true
  
  validates :input_language, presence: true, :inclusion => {:in => LANGUAGES, :message => "is not a valid language" }
  validates :output_1_language, presence: true, :inclusion => {:in => LANGUAGES, :message => "is not a valid language" }
  validates :output_2_language, allow_blank: true, :inclusion => {:in => LANGUAGES, :message => "is not a valid language" }
  validates :output_3_language, allow_blank: true, :inclusion => {:in => LANGUAGES, :message => "is not a valid language" }
  validates :output_4_language, allow_blank: true, :inclusion => {:in => LANGUAGES, :message => "is not a valid language" }
  validates :output_5_language, allow_blank: true, :inclusion => {:in => LANGUAGES, :message => "is not a valid language" }

  # Associations
  belongs_to :user, class_name: "ClientUser"
  belongs_to :folder, class_name: "DocumentFolder", optional: true, foreign_key: :folder_id
  has_many :items, class_name: "TableDocumentItem"
  
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
