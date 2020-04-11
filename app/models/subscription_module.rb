class SubscriptionModule < ApplicationRecord

  # Constants
  #LANGUAGES = ["ENGLISH", "ARABIC", "FRENCH"].freeze

  # Set Table Name
  self.table_name = "subscription_modules"

 
#Association
  #belongs_to :modules
  # Generic Methods
 
  def access
    UserModule.where('id=?',modules_id)
  end
  

end