class Document::TableBased < ApplicationRecord
   
  # Associations
  has_many :items, class_name: "Document::Item"

end
