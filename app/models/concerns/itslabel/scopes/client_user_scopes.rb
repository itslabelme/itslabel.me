module Itslabel::Scopes::ClientUserScopes
  
  extend ActiveSupport::Concern

  included do

    # Scopes
    scope :search, lambda {|query| where("
      LOWER(client_users.first_name) LIKE LOWER('%#{query}%') OR\
      LOWER(client_users.last_name) LIKE LOWER('%#{query}%') OR\
      LOWER(client_users.mobile_number) LIKE LOWER('%#{query}%') OR\
      LOWER(client_users.email) LIKE LOWER('%#{query}%') OR\
      LOWER(client_users.country) LIKE ('%#{query}%')
    ")}
     scope :advsearch, lambda {|query| where("
      #{query}
    ")}
    scope :upcoming, lambda { where("client_users.created_at >= ?", Time.now) }
    scope :past, lambda { where("client_users.created_at < ?", Time.now) }

  end
  
end