class Subscription < ApplicationRecord

  # Constants
  #LANGUAGES = ["ENGLISH", "ARABIC", "FRENCH"].freeze

  # Set Table Name
  self.table_name = "subscriptions"

  # Validations
  validates :title , length: {maximum: 256}, allow_blank: false, :uniqueness => true
  #validates :price, allow_blank: true

  
end