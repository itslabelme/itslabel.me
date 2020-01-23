class Document::TemplateBased < Document::Base
   
  # Associations
  belongs_to :template, class_name: "Template", optional: true

end
