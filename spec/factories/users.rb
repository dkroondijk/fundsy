FactoryGirl.define do
  factory :user do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    password Faker::Internet.password(12)
    # factory normally only produces one unique instance
    # have to use sequence to generate different email addresses
    sequence(:email) {|n| "awesome_email_#{n}@gmail.com"}
  end

end
