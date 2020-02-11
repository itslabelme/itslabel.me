module Itslabel::Scopes::TableDocumentScopes
  
  extend ActiveSupport::Concern

  included do

    # Scopes
    scope :search, lambda {|query| where("
      LOWER(table_documents.title) LIKE LOWER('%#{query}%') OR\
      LOWER(table_documents.description) LIKE LOWER('%#{query}%') OR\
      LOWER(table_documents.input_language) LIKE LOWER('%#{query}%') OR\
      LOWER(table_documents.status) LIKE LOWER('%#{query}%') 

    ")}

    scope :search_only_title, lambda {|title| title.to_s.blank? ? where("") : where("
      LOWER(table_documents.title) LIKE LOWER('%#{title}%')
    ")}

    scope :search_only_input_phrase, lambda {|title| title.to_s.blank? ? where("") : where("
      LOWER(table_documents.input_phrase) LIKE LOWER('%#{title}%')
    ")}

    scope :filter_by_output_language, lambda {|output_phrase| output_phrase.to_s.blank? ? where("") : where("
      LOWER(table_documents.output_1_phrase) LIKE LOWER('%#{output_phrase}%') OR\
      LOWER(table_documents.output_2_phrase) LIKE LOWER('%#{output_phrase}%') OR\
      LOWER(table_documents.output_3_phrase) LIKE LOWER('%#{output_phrase}%') OR\
      LOWER(table_documents.output_4_phrase) LIKE LOWER('%#{output_phrase}%') OR\
      LOWER(table_documents.output_5_phrase) LIKE LOWER('%#{output_phrase}%')
    ")}

    scope :search_only_input_language, lambda {|input_language| input_language.to_s.blank? ? where("") : where("
      LOWER(table_documents.input_language) LIKE LOWER('%#{input_language}%')
    ")}
    
    # scope :search_only_output_language, lambda {|output_language| output_language.to_s.blank? ? where("") : where("
    #   LOWER(table_documents.output_language) LIKE LOWER('%#{output_language}%')
    # ")}

    scope :only_favorites, lambda { where(:favorite, true) }
    scope :not_favorites, lambda { where(:favorite, false) }

    scope :recent, lambda { where("template_documents.created_at >= ?", 1.month.ago) }

  end
  
end