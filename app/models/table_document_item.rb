class TableDocumentItem < ApplicationRecord
  
  # Constants
  LANGUAGES = ["ENGLISH", "ARABIC", "FRENCH", "SPANISH"].freeze

  # Set Table Name
  self.table_name = "table_document_items"

  attr_accessor :temporary_key

  # Validations
  validates :input_phrase, presence: true, length: {maximum: 256}, allow_blank: true
  validates :input_language, presence: true, :inclusion => {:in => LANGUAGES, :message => "is not a valid language" }

  validates :output_1_phrase, presence: true, length: {maximum: 256}, allow_blank: true
  validates :output_1_language, presence: true, :inclusion => {:in => LANGUAGES, :message => "is not a valid language" }

  validates :output_2_phrase, length: {maximum: 256}, allow_blank: true
  validates :output_2_language, :inclusion => {:in => LANGUAGES, :message => "is not a valid language" }, allow_blank: true

  validates :output_3_phrase, length: {maximum: 256}, allow_blank: true
  validates :output_3_language, :inclusion => {:in => LANGUAGES, :message => "is not a valid language" }, allow_blank: true

  validates :output_4_phrase, length: {maximum: 256}, allow_blank: true
  validates :output_4_language, :inclusion => {:in => LANGUAGES, :message => "is not a valid language" }, allow_blank: true

  validates :output_5_phrase, length: {maximum: 256}, allow_blank: true
  validates :output_5_language, :inclusion => {:in => LANGUAGES, :message => "is not a valid language" }, allow_blank: true

  # Associations
  belongs_to :table_document, class_name: "TableDocument"
  belongs_to :output_1_translation, class_name: "Translation", optional: true
  belongs_to :output_2_translation, class_name: "Translation", optional: true
  belongs_to :output_3_translation, class_name: "Translation", optional: true
  belongs_to :output_4_translation, class_name: "Translation", optional: true
  belongs_to :output_5_translation, class_name: "Translation", optional: true

  # Callbacks
  before_save :sanitize_phrases, :translate_phrases

  # ----------------
  # Instance Methods
  # ----------------

  def sanitize_phrases
    self.input_phrase.strip! if self.input_phrase
    self.output_1_phrase.strip! if self.output_1_phrase
    self.output_2_phrase.strip! if self.output_2_phrase
    self.output_3_phrase.strip! if self.output_3_phrase
    self.output_4_phrase.strip! if self.output_4_phrase
    self.output_5_phrase.strip! if self.output_5_phrase
  end

  def translate_phrases
    return if self.translated
    self.output_1_language = self.table_document.output_1_language
    self.output_2_language = self.table_document.output_2_language
    self.output_3_language = self.table_document.output_3_language
    self.output_4_language = self.table_document.output_4_language
    self.output_5_language = self.table_document.output_5_language

    self.output_1_phrase = Translation.translate(self.input_phrase, input_language: self.input_language, output_language: self.output_1_language) if self.output_1_language  && self.output_1_phrase.blank?
    self.output_2_phrase = Translation.translate(self.input_phrase, input_language: self.input_language, output_language: self.output_2_language) if self.output_2_language  && self.output_2_phrase.blank?
    self.output_3_phrase = Translation.translate(self.input_phrase, input_language: self.input_language, output_language: self.output_3_language) if self.output_3_language  && self.output_3_phrase.blank?
    self.output_4_phrase = Translation.translate(self.input_phrase, input_language: self.input_language, output_language: self.output_4_language) if self.output_4_language  && self.output_4_phrase.blank?
    self.output_5_phrase = Translation.translate(self.input_phrase, input_language: self.input_language, output_language: self.output_5_language) if self.output_5_language  && self.output_5_phrase.blank?

    # self.output_1_phrase = Translation.translate(self.input_phrase, output_language: self.output_1_language) if self.output_1_language && self.output_1_phrase.blank?
    # self.output_2_phrase = Translation.translate(self.input_phrase, output_language: self.output_2_language) if self.output_2_language && self.output_2_phrase.blank?
    # self.output_3_phrase = Translation.translate(self.input_phrase, output_language: self.output_3_language) if self.output_3_language && self.output_3_phrase.blank?
    # self.output_4_phrase = Translation.translate(self.input_phrase, output_language: self.output_4_language) if self.output_4_language && self.output_4_phrase.blank?
    # self.output_5_phrase = Translation.translate(self.input_phrase, output_language: self.output_5_language) if self.output_5_language && self.output_5_phrase.blank?
  end

end
