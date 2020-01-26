class LabelTemplate < ApplicationRecord

  # Set Table Name
  self.table_name = "label_templates"

  # Imports
  extend Importer

  # Includes
  # include Itslabel::Status::LabelTemplateStatus
  # include Itslabel::Scopes::LabelTemplateScopes
  # include Itslabel::Permissions::LabelTemplatePermissions
  # include Itslabel::Validations::LabelTemplateValidations
  # include Itslabel::Callbacks::LabelTemplateCallbacks
  # include Itslabel::Imports::LabelTemplateImports
  
  # Validations
  validates :name, presence: true, length: {maximum: 256}, allow_blank: false
  validates :description, length: {maximum: 1024}, allow_blank: true
  validates :style, presence: true, length: {maximum: 64}, allow_blank: false
  
  validates :ltr_html_source, presence: true

  # Associations
  belongs_to :admin_user, class_name: "AdminUser", optional: true

  
  # Generic Methods
  # ---------------
  def display_name
    "#{self.name} - #{self.style}"
  end
  
  
end