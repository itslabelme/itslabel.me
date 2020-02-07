class Document::TableBased < Document::Base
   
  # Associations
  has_many :items, class_name: "Document::Item"

  def display_type
    "Table - Based"
  end

end
