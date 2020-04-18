class SubscriptionPermission < ApplicationRecord

  # Constants
  #LANGUAGES = ["ENGLISH", "ARABIC", "FRENCH"].freeze

  # Set Table Name
  self.table_name = "subscription_permissions"

 
#Association
 # belongs_to :permissions
  # Generic Methods
 
  def access
    Permission.where('id=?',permission_id)
  end
  

end