class UserSubscription < ApplicationRecord

  # Constants
  #LANGUAGES = ["ENGLISH", "ARABIC", "FRENCH"].freeze
  
  SUBSCRIPTION_PLAN_ORDER = {
                             "#{Rails.application.secrets.zoho_free_plan_code}": 0, 
                             "#{Rails.application.secrets.zoho_month_plan_code}": 1,
                             "#{Rails.application.secrets.zoho_3month_plan_code}": 2,
                             "#{Rails.application.secrets.zoho_6month_plan_code}": 3,
                             "#{Rails.application.secrets.zoho_12month_plan_code}": 4
                            } 
  # Set Table Name
  #self.table_name = "user_subscriptions"

  # Validations
  validates :subscription_id, presence: true,  allow_blank: false

  belongs_to :client_user, foreign_key: :user_id
  # belongs_to :client_user
  belongs_to :subscription

end