FactoryBot.define do
  
  factory :translation, class: Translation do

    status { "APPROVED" }
    
    after(:build) do |t|
    end

    trait :pending do
      status { "PENDING" }
    end

    trait :approved do
      status { "APPROVED" }
    end

    trait :with_admin_user do
      after :build do |t|
        t.admin_user = (AdminUser.first || FactoryBot.build(:admin_user)) unless t.admin_user
      end
    end
    
  end

  factory :english_to_arabic_translation, parent: :translation do
    input_phrase { "Amino Acids" }
    output_phrase { "أحماض أمينية" }

    input_language { "ENGLISH" }
    output_language { "ARABIC" }
  end

  factory :english_to_french_translation, parent: :translation do
    input_phrase { "Amino Acids" }
    output_phrase { "Acides aminés" }

    input_language { "ENGLISH" }
    output_language { "FRENCH" }
  end
  
end