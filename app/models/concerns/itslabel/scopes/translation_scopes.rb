module Itslabel::Scopes::TranslationScopes
  
  extend ActiveSupport::Concern

  included do

    # Scopes
    scope :search, lambda {|query| where("
      LOWER(translations.input_phrase) LIKE LOWER('%#{query}%') OR\
      
      LOWER(translations.input_language) LIKE LOWER('%#{query}%') OR\

      LOWER(translations.output_phrase) LIKE LOWER('%#{query}%') OR\
      LOWER(translations.output_language) LIKE LOWER('%#{query}%') 
    

    ")}
     scope :advsearch, lambda {|query| where("
      #{query}

    ")}
    scope :upcoming, lambda { where("translations.created_at >= ?", Time.now) }
    scope :past, lambda { where("translations.created_at < ?", Time.now) }

  end
  
end