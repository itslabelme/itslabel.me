module Itslabel::Scopes::ClientUserScopes
  
  extend ActiveSupport::Concern

  included do

    # Scopes
    scope :search, lambda {|query| where("
      LOWER(client_users.first_name) LIKE LOWER('%#{query}%') OR\
      LOWER(client_users.last_name) LIKE LOWER('%#{query}%') OR\
      LOWER(client_users.mobile_number) LIKE LOWER('%#{query}%') OR\
      LOWER(client_users.email) LIKE LOWER('%#{query}%') OR\
      LOWER(client_users.organisation) LIKE LOWER('%#{query}%') OR\
      LOWER(client_users.country) LIKE ('%#{query}%')
    ")}
    
    scope :filter_by_country, lambda {|country| country.to_s.blank? ? where("") : where("
      LOWER(client_users.country) = LOWER('#{ISO3166::Country[country].translations[I18n.locale.to_s]}')
    ")}

    scope :search_only_mobile_number, lambda {|mobile_number| mobile_number.to_s.blank? ? where("") : where("
      LOWER(client_users.mobile_number) LIKE LOWER('%#{mobile_number}%')
    ")}

    scope :upcoming, lambda { where("client_users.created_at >= ?", Time.now) }
    scope :past, lambda { where("client_users.created_at < ?", Time.now) }

  end
  
end