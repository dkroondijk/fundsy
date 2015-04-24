FactoryGirl.define do
  factory :pledge do
    association :user, factory: :user
    association :campaign, factory: :campaign
    amount 10
  end

end
