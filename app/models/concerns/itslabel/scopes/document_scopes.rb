module Itslabel::Scopes::DocumentScopes
  
  extend ActiveSupport::Concern

  included do

    # Scopes
    scope :search, lambda {|query| where("
      LOWER(documents.title) LIKE LOWER('%#{query}%') OR\
      LOWER(documents.description) LIKE LOWER('%#{query}%') OR\
      LOWER(documents.input_language) LIKE LOWER('%#{query}%') OR\
      LOWER(documents.status) LIKE LOWER('%#{query}%') 

    ")}

    # binding.pry

    scope :search_only_title, lambda {|title| title.to_s.blank? ? where("") : where("
      LOWER(documents.title) LIKE LOWER('%#{title}%')
    ")}
    scope :search_only_output_phrase, lambda {|output_phrase| output_phrase.to_s.blank? ? where("") : where("
      LOWER(documents.output_phrase) LIKE LOWER('%#{output_phrase}%')
    ")}
    scope :search_only_input_language, lambda {|input_language| input_language.to_s.blank? ? where("") : where("
      LOWER(documents.input_language) LIKE LOWER('%#{input_language}%')
    ")}
    # scope :search_only_output_language, lambda {|output_language| output_language.to_s.blank? ? where("") : where("
    #   LOWER(documents.output_language) LIKE LOWER('%#{output_language}%')
    # ")}
    scope :search_only_status, lambda {|status| status.to_s.blank? ? where("") : where("
      LOWER(documents.status) LIKE LOWER('%#{status}%')
    ")}
    scope :upcoming, lambda { where("documents.created_at >= ?", Time.now) }
    scope :past, lambda { where("documents.created_at < ?", Time.now) }


    scope :upcoming, lambda { where("documents.created_at >= ?", Time.now) }
    scope :past, lambda { where("documents.created_at < ?", Time.now) }

  end
  
end