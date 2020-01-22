class Document::TemplateBased < ApplicationRecord
   
  # Associations
  belongs_to :template, class_name: "Template"

end
