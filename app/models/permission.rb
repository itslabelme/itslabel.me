class Permission < ApplicationRecord

  # Constants
  #LANGUAGES = ["ENGLISH", "ARABIC", "FRENCH"].freeze

  # Set Table Name
  self.table_name = "permissions"

  validates :title, presence: true, length: {maximum: 256}, allow_blank: false, :uniqueness => true
  validates :route, length: {maximum: 256}, allow_blank: false, :uniqueness => true
  validates :permission_group, length: {maximum: 256}, allow_blank: false
  validates :description, length: {maximum: 24}, allow_blank: true
#Association 
 #has_many :subscription_permission, class_name: "SubscriptionPermission", foreign_key: :permission_id
  
  # Generic Methods
 
  
  
end