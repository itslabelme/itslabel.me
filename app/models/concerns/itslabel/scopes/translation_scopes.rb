module Itslabel::Scopes::TranslationScopes
  
  extend ActiveSupport::Concern

  included do

    # Scopes
    scope :search, lambda {|query| where("
      LOWER(translations.input_phrase) LIKE LOWER(?) OR\
    
      LOWER(translations.input_language) LIKE LOWER(?) OR\

      LOWER(translations.output_phrase) LIKE LOWER(?) OR\
      LOWER(translations.output_language) LIKE LOWER(?) 
    ", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%")}
 
    scope :search_only_input_phrase, lambda {|input_phrase| input_phrase.to_s.blank? ? where("") : where("
      LOWER(translations.input_phrase) LIKE LOWER(?)", "%#{input_phrase}%")}

    scope :search_only_output_phrase, lambda {|output_phrase| output_phrase.to_s.blank? ? where("") : where("
      LOWER(translations.output_phrase) LIKE LOWER(?)", output_phrase)}

    scope :search_only_input_language, lambda {|input_language| input_language.to_s.blank? ? where("") : where("
      LOWER(translations.input_language) = LOWER(?)", input_language)}

    scope :search_only_output_language, lambda {|output_language| output_language.to_s.blank? ? where("") : where("
      LOWER(translations.output_language) = LOWER(?)", output_language)}

    scope :search_only_status, lambda {|status| status.to_s.blank? ? where("") : where("
      LOWER(translations.status) = LOWER(?)", status)}

    scope :upcoming, lambda { where("translations.created_at >= ?", Time.now) }
    scope :past, lambda { where("translations.created_at < ?", Time.now) }

    scope :order_by, lambda { |col| 
      case col
      when "input_phrase_asc"
        order("#{table_name}.input_phrase ASC")
      when "input_phrase_desc"
        order("#{table_name}.input_phrase DESC")
      when "created_at_asc"
        order("#{table_name}.created_at ASC")
      when "created_at_desc"
        order("#{table_name}.created_at DESC")
      else
        order("#{table_name}.created_at DESC")
      end
    }
    

  end
  
end