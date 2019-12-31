class Translation < ApplicationRecord

  # Set Table Name
  self.table_name = "translations"


  # Includes
  # include Itslabel::Status::TranslationStatus
  include Itslabel::Scopes::TranslationScopes
  include Itslabel::Permissions::TranslationPermissions
  include Itslabel::Validations::TranslationValidations

  # Validations
  validates :input_phrase, presence: true, length: {maximum: 256}, allow_blank: false
  validates :input_language, presence: true, length: {maximum: 16}, allow_blank: false
  validates :output_phrase, presence: true, length: {maximum: 256}, allow_blank: false
  validates :output_language, presence: true, length: {maximum: 16}, allow_blank: false
  
  # Associations

  
  
  # Generic Methods
  # ---------------
  def to_param
    "#{id}-#{input_phrase_was}".parameterize[0..32]
  end

  # def translate_from_english_to_arabic(word)
  #   self.where(self.input_language: 'ENGLISH', self.output_language: "ARABIC", LOWER(input_phrase): LOWER(word)).select(:output_phrase)
  # end

  # def translate_from_english_to_french(word)
  #   self.where(self.input_language: 'ENGLISH', self.output_language: "FRENCH", LOWER(input_phrase): LOWER(word)).select(:output_phrase)
  # end

  # def translate_from_arabic_to_french(word)
  #   self.where(self.input_language: 'ARABIC', self.output_language: "FRENCH", LOWER(input_phrase): LOWER(word)).select(:output_phrase)
  # end

  # def translate_from_arabic_to_english(word)
  #   self.where(self.input_language: 'ARABIC', self.output_language: "ENGLISH", LOWER(input_phrase): LOWER(word)).select(:output_phrase)
  # end

  # def translate_from_french_to_english(word)
  #   self.where(self.input_language: 'FRENCH', self.output_language: "ENGLISH", LOWER(input_phrase): LOWER(word)).select(:output_phrase)
  # end

  # def translate_from_french_to_arabic(word)
  #   self.where(self.input_language: 'FRENCH', self.output_language: "ARABIC", LOWER(input_phrase): LOWER(word)).select(:output_phrase)
  # end

  # def lookup_word_in_english(word)
  #   self.where("LOWER(self.input_phrase) LIKE LOWER('%#{word}%') AND self.input_language = 'ENGLISH' " ).select(:output_phrase)
  # end

  # def lookup_word_in_arabic(word)
  #   self.where("LOWER(self.input_phrase) LIKE LOWER('%#{word}%') AND self.input_language = 'ARABIC' " ).select(:output_phrase)
  # end

  # def lookup_word_in_french(word)
  #   self.where("LOWER(self.input_phrase) LIKE LOWER('%#{word}%') AND self.input_language = 'FRENCH' " ).select(:output_phrase)
  # end
  
end