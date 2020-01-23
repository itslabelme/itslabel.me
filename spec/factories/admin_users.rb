FactoryBot.define do
  
  factory :admin_user, class: AdminUser do

    first_name { "Admin" }
    last_name { "User" }
    mobile_number { "+971501234567" }
    sequence(:email) { |n| "admin#{n}@yopmail.com" }

    after(:build) do |au|
      au.password = "Password@1"
      au.password_confirmation = "Password@1"
    end
    
  end
  
end