class Document::Item < ApplicationRecord
  
  # Constants
  LANGUAGES = ["ENGLISH", "ARABIC", "FRENCH"].freeze

  # Set Table Name
  self.table_name = "document_items"

  # Validations
  validates :input_phrase, presence: true, length: {maximum: 256}, allow_blank: false
  validates :input_language, presence: true, :inclusion => {:in => LANGUAGES, :message => "is not a valid language" }

  validates :output_1_phrase, presence: true, length: {maximum: 256}, allow_blank: false
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
  belongs_to :translation, class_name: "Translation", optional: true
  belongs_to :document, class_name: "Document"

  # Callbacks
  before_save :sanitize_phrases, :translate_phrases

  # General Methods
  # ---------------

  def sanitize_phrases
    self.input_phrase.strip!
    self.output_1_phrase.strip!
    self.output_2_phrase.strip!
    self.output_3_phrase.strip!
    self.output_4_phrase.strip!
    self.output_5_phrase.strip!
  end

  def translate_phrases
    self.output_1_language = self.document.output_1_language
    self.output_2_language = self.document.output_2_language
    self.output_3_language = self.document.output_3_language
    self.output_4_language = self.document.output_4_language
    self.output_5_language = self.document.output_5_language

    self.output_1_phrase = Translation.translate(self.input_phrase, output_language: self.output_1_language) if self.output_1_language && self.output_1_phrase.blank?
    self.output_2_phrase = Translation.translate(self.input_phrase, output_language: self.output_2_language) if self.output_2_language && self.output_2_phrase.blank?
    self.output_3_phrase = Translation.translate(self.input_phrase, output_language: self.output_3_language) if self.output_3_language && self.output_3_phrase.blank?
    self.output_4_phrase = Translation.translate(self.input_phrase, output_language: self.output_4_language) if self.output_4_language && self.output_4_phrase.blank?
    self.output_5_phrase = Translation.translate(self.input_phrase, output_language: self.output_5_language) if self.output_5_language && self.output_5_phrase.blank?
  end

end
