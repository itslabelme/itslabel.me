module Itslabel::Scopes::TemplateDocumentScopes
  
  extend ActiveSupport::Concern

  included do

    # Scopes
    scope :search, lambda {|query| where("
      LOWER(template_documents.title) LIKE LOWER('%#{query}%') OR\
      LOWER(template_documents.input_language) LIKE LOWER('%#{query}%') OR\
      LOWER(template_documents.output_language) LIKE LOWER('%#{query}%') OR\
      LOWER(template_documents.status) LIKE LOWER('%#{query}%')
    ")}

    scope :search_only_title, lambda {|title| title.to_s.blank? ? where("") : where("
      LOWER(template_documents.title) LIKE LOWER('%#{title}%')
    ")}

    scope :search_only_output_phrase, lambda {|output_phrase| output_phrase.to_s.blank? ? where("") : where("
      LOWER(template_documents.output_phrase) LIKE LOWER('%#{output_phrase}%')
    ")}

    scope :search_only_input_language, lambda {|input_language| input_language.to_s.blank? ? where("") : where("
      LOWER(template_documents.input_language) LIKE LOWER('%#{input_language}%')
    ")}
     scope :search_only_status, lambda {|status| status.to_s.blank? ? where("") : where("
      LOWER(template_documents.status) LIKE LOWER('%#{status}%')
    ")}
    # scope :search_only_output_language, lambda {|output_language| output_language.to_s.blank? ? where("") : where("
    #   LOWER(template_documents.output_language) LIKE LOWER('%#{output_language}%')
    # ")}

    scope :only_favorites, lambda { where(:favorite, true) }
    scope :not_favorites, lambda { where(:favorite, false) }

    scope :recent, lambda { where("template_documents.created_at >= ?", 1.month.ago) }

  end
  
end