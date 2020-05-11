class DocumentFolder < ApplicationRecord

   validates :title, length: {maximum: 256}, allow_blank: false
   validates :title, uniqueness: { scope: :user_id }
  def getChild(id)
    @folder = DocumentFolder.where(parent_id:id)
  end
  # Associations
  #has_many :template_documents, class_name: "TemplateDocument", foreign_key: :folder_id
  # Associations
  #has_many :table_documents, class_name: "TableDocument", foreign_key: :folder_id
  has_many :documents, class_name: "DocumentView", foreign_key: :folder_id
end