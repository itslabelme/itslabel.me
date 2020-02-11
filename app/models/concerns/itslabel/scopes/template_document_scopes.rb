module Itslabel::Scopes::TemplateDocumentScopes
  
  extend ActiveSupport::Concern

  included do

    # Scopes
    scope :search, lambda {|query| query.to_s.strip.blank? ? where("") : where("
      LOWER(template_documents.title) LIKE LOWER('%#{query}%') OR\
      LOWER(template_documents.input_language) LIKE LOWER('%#{query}%') OR\
      LOWER(template_documents.output_language) LIKE LOWER('%#{query}%') OR\
      LOWER(template_documents.status) LIKE LOWER('%#{query}%')
    ")}

    scope :search_only_title, lambda {|title| title.to_s.strip.blank? ? where("") : where("
      LOWER(template_documents.title) LIKE LOWER('%#{title}%')
    ")}

    scope :search_only_input_language, lambda {|lang| lang.to_s.strip.blank? ? where("") : where("
      LOWER(template_documents.input_language) LIKE LOWER('%#{lang}%')
    ")}

    scope :search_only_output_language, lambda {|lang| lang.to_s.strip.blank? ? where("") : where("
      LOWER(template_documents.output_language) LIKE LOWER('%#{lang}%')
    ")}

    scope :only_favorites, lambda { where(:favorite, true) }
    scope :not_favorites, lambda { where(:favorite, false) }

    scope :recent, lambda { where(created_at: 1.month.ago..Time.now).or(TemplateDocument.where(updated_at: 1.month.ago..Time.now)) }

  end
  
end