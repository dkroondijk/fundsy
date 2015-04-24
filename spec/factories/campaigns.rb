FactoryGirl.define do
  factory :campaign do
    association :user, factory: :user
    title Faker::Company.bs
    description Faker::Lorem.paragraph
    goal 1000000
  end

end
