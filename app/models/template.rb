class Template < ApplicationRecord

  # Set Table Name
  self.table_name = "templates"

  # Imports
  extend Importer

  # Includes
  # include Itslabel::Status::TemplateStatus
  # include Itslabel::Scopes::TemplateScopes
  # include Itslabel::Permissions::TemplatePermissions
  # include Itslabel::Validations::TemplateValidations
  # include Itslabel::Callbacks::TemplateCallbacks
  # include Itslabel::Imports::TemplateImports
  
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
    self.name
  end
  
  
end