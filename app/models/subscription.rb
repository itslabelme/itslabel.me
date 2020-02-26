class Subscription < ApplicationRecord

  # Constants
  #LANGUAGES = ["ENGLISH", "ARABIC", "FRENCH"].freeze

  # Set Table Name
  self.table_name = "subscriptions"

 

  
  # Generic Methods
  # ---------------
  def display_name
    "#{input_phrase} - #{output_phrase}"
  end
  
  
end