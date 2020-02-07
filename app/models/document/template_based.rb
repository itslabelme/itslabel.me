class Document::TemplateBased < Document::Base
   
  # Associations
  belongs_to :template, class_name: "LabelTemplate", optional: true

  # Callbacks
  before_save :translate, unless: :skip_callback

  def display_type
    "Template - Based"
  end

  def display_template
    template.try(:name)
  end

end
