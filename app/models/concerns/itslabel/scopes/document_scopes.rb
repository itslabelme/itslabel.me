module Itslabel::Scopes::DocumentScopes
  
  extend ActiveSupport::Concern

  included do

    # Scopes
    scope :search, lambda {|query| query.to_s.strip.blank? ? where("") : where("
      LOWER(documents_view.title) LIKE LOWER('%#{query}%') OR\
      LOWER(documents_view.input_language) LIKE LOWER('%#{query}%') OR\
      LOWER(documents_view.status) LIKE LOWER('%#{query}%')
    ")}

    scope :search_only_title, lambda {|title| title.to_s.strip.blank? ? where("") : where("
      LOWER(documents_view.title) LIKE LOWER('%#{title}%')
    ")}
  
   scope :search_only_folder, lambda {|folder_id| folder_id.blank? ? where("") : where("
      documents_view.folder_id LIKE '#{folder_id}'
    ")}

    scope :search_only_input_language, lambda {|lang| lang.to_s.strip.blank? ? where("") : where("
      LOWER(documents_view.input_language) LIKE LOWER('%#{lang}%')
    ")}

    scope :search_only_output_language, lambda {|lang| lang.to_s.strip.blank? ? where("") : where("
      LOWER(documents_view.output_1_language) LIKE LOWER('%#{lang}%') OR\
      LOWER(documents_view.output_2_language) LIKE LOWER('%#{lang}%') OR\
      LOWER(documents_view.output_3_language) LIKE LOWER('%#{lang}%') OR\
      LOWER(documents_view.output_4_language) LIKE LOWER('%#{lang}%') OR\
      LOWER(documents_view.output_5_language) LIKE LOWER('%#{lang}%')
    ")}

     scope :search_only_status, lambda {|status| status.to_s.blank? ? where("") : where("
      LOWER(documents_view.status) LIKE LOWER('%#{status}%')
    ")}

    # scope :search_only_output_language, lambda {|output_language| output_language.to_s.blank? ? where("") : where("
    #   LOWER(documents_view.output_language) LIKE LOWER('%#{output_language}%')
    # ")}


    scope :only_favorites, lambda { where(:favorite, true) }
    scope :not_favorites, lambda { where(:favorite, false) }

    scope :recent, lambda { where(created_at: 1.month.ago..Time.now).or(DocumentView.where(updated_at: 1.month.ago..Time.now)) }

  end
  
end