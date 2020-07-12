class SubscriptionPermission < ApplicationRecord

  # Set Table Name
  self.table_name = "subscription_permissions"

  # -----------------
  # Instance Methods
  # -----------------
 
  def access
    Permission.where('id=?',permission_id)
  end

end