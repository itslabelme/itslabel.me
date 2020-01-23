FactoryBot.define do
  
  factory :client_user, class: ClientUser do

    first_name { "Client" }
    last_name { "User" }
    organisation { "Client Organisation" }
    country { "United Kingdom" }
    mobile_number { "+971501234567" }
    sequence(:email) { |n| "client-user#{n}@yopmail.com" }

    after(:build) do |cu|
      cu.password = "Password@1"
      cu.password_confirmation = "Password@1"
    end
    
  end
  
end