module Itslabel::Scopes::TranslationScopes
  
  extend ActiveSupport::Concern

  included do

    # Scopes
    scope :search, lambda {|query| where("
      LOWER(translations.arabic_phrase) LIKE LOWER(?) OR\
    
      LOWER(translations.english_phrase) LIKE LOWER(?) OR\

      LOWER(translations.french_phrase) LIKE LOWER(?)  

    ", "%#{query}%", "%#{query}%", "%#{query}%")}
 
    scope :search_only_english_phrase, lambda {|english_phrase| english_phrase.to_s.blank? ? where("") : where("
      LOWER(translations.english_phrase) LIKE LOWER(?)", "%#{english_phrase}%")}

    scope :search_only_arabic_phrase, lambda {|arabic_phrase| arabic_phrase.to_s.blank? ? where("") : where("
      LOWER(translations.arabic_phrase) LIKE LOWER(?)", arabic_phrase)}

    scope :search_only_french_phrase, lambda {|french_phrase| french_phrase.to_s.blank? ? where("") : where("
      LOWER(translations.french_phrase) LIKE LOWER(?)", french_phrase)}
    

    scope :search_only_status, lambda {|status| status.to_s.blank? ? where("") : where("
      LOWER(translations.status) = LOWER(?)", status)}

    scope :upcoming, lambda { where("translations.created_at >= ?", Time.now) }
    scope :past, lambda { where("translations.created_at < ?", Time.now) }

  end
  
end