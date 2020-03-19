class Folder < ApplicationRecord

   validates :title, length: {maximum: 256}, allow_blank: false
  def getChild(id)
    @folder = Folder.where(parent_id:id)
  end
  # Associations
  has_many :template_documents, class_name: "TemplateDocument", foreign_key: :folder_id
  # Associations
  has_many :table_documents, class_name: "TableDocument", foreign_key: :folder_id
  has_many :documents, class_name: "DocumentView", foreign_key: :folder_id
end