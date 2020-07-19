class UserSubscription < ApplicationRecord

  # Constants
  #LANGUAGES = ["ENGLISH", "ARABIC", "FRENCH"].freeze

  # Set Table Name
  #self.table_name = "user_subscriptions"

  # Validations
  validates :subscription_id, presence: true,  allow_blank: false

  # belongs_to :client_user
  # belongs_to :subscription

end