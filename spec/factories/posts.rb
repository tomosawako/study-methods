FactoryBot.define do
  factory :post do
    field { Faker::Lorem.characters(number:10)}
    reference_book { Faker::Lorem.characters(number:10)}
    study_method { Faker::Lorem.characters(number:30)}
    total_study_time { rand(1..100) }
    achievement { Faker::Lorem.characters(number:30)}
    enduser
    category
  end
end
