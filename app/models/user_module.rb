class UserModule < ApplicationRecord

  # Constants
  #LANGUAGES = ["ENGLISH", "ARABIC", "FRENCH"].freeze

  # Set Table Name
  self.table_name = "modules"

 
#Association 
has_many :subscription_module, class_name: "SubscriptionModule", foreign_key: :modules_id
  
  # Generic Methods
 
  
  
end