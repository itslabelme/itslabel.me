module Itslabel::Scopes::TranslationRequestScopes
  
  extend ActiveSupport::Concern

  included do

    # Scopes
    scope :search, lambda {|query| where("
      LOWER(translation_requests.input_phrase) LIKE LOWER(?) OR\
    
      LOWER(translation_requests.input_language) LIKE LOWER(?) OR\

      LOWER(translation_requests.output_phrase) LIKE LOWER(?) OR\
      LOWER(translation_requests.output_language) LIKE LOWER(?) 
    ", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%")}
 
    scope :search_only_input_phrase, lambda {|input_phrase| input_phrase.to_s.blank? ? where("") : where("
      LOWER(translation_requests.input_phrase) LIKE LOWER(?)", "%#{input_phrase}%")}

    scope :search_only_output_phrase, lambda {|output_phrase| output_phrase.to_s.blank? ? where("") : where("
      LOWER(translation_requests.output_phrase) LIKE LOWER(?)", output_phrase)}

    scope :search_only_input_language, lambda {|input_language| input_language.to_s.blank? ? where("") : where("
      LOWER(translation_requests.input_language) = LOWER(?)", input_language)}

    scope :search_only_output_language, lambda {|output_language| output_language.to_s.blank? ? where("") : where("
      LOWER(translation_requests.output_language) = LOWER(?)", output_language)}

    scope :search_only_status, lambda {|status| status.to_s.blank? ? where("") : where("
      LOWER(translation_requests.status) = LOWER(?)", status)}

    scope :upcoming, lambda { where("translations.created_at >= ?", Time.now) }
    scope :past, lambda { where("translations.created_at < ?", Time.now) }

  end
  
end