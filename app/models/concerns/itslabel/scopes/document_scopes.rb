module Itslabel::Scopes::DocumentScopes
  
  extend ActiveSupport::Concern

  included do

    # Scopes
    scope :search, lambda {|query| where("
      LOWER(documents.title) LIKE LOWER('%#{query}%') OR\
      LOWER(documents.description) LIKE LOWER('%#{query}%') OR\
      LOWER(documents.input_language) LIKE LOWER('%#{query}%') OR\
      LOWER(documents.status) LIKE LOWER('%#{query}%') OR\

    ")}
    
    scope :upcoming, lambda { where("documents.created_at >= ?", Time.now) }
    scope :past, lambda { where("documents.created_at < ?", Time.now) }

  end
  
end