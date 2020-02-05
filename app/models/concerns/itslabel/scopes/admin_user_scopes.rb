module Itslabel::Scopes::AdminUserScopes
  
  extend ActiveSupport::Concern

  included do

    # Scopes
    scope :search, lambda {|query| where("
      LOWER(admin_users.first_name) LIKE LOWER('%#{query}%') OR\
      LOWER(admin_users.last_name) LIKE LOWER('%#{query}%') OR\
      LOWER(admin_users.mobile_number) LIKE LOWER('%#{query}%') OR\
      LOWER(admin_users.email) LIKE LOWER('%#{query}%')
    ")}
    
    scope :upcoming, lambda { where("admin_users.created_at >= ?", Time.now) }
    scope :past, lambda { where("admin_users.created_at < ?", Time.now) }

  end
  
end