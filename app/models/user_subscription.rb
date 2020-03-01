class UserSubscription < ApplicationRecord

  # Constants
  #LANGUAGES = ["ENGLISH", "ARABIC", "FRENCH"].freeze

  # Set Table Name
  self.table_name = "user_subscriptions"

 validates :subscription_id, presence: true,  allow_blank: false

  
  # Generic Methods
 
  
  
end