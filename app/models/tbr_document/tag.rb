# class Tag < ApplicationRecord
#   # Set Table Name
#   self.table_name = "tags"

#   # Validations
#   validates :name, presence: true, length: {maximum: 256}

#   # Associations
#   has_many :tag_mappings, class_name: "TagMapping", dependent: :destroy, foreign_key: :tag_id
#   has_many :documents, -> { distinct }, through: :tag_mappings

#   # has_and_belongs_to_many :documents, class_name: "Document",  join_table: :documents_tags
#   # has_and_belongs_to_many :nutrition_facts, class_name: "NutritionFact",  join_table: :nutrition_facts_tags
# end
