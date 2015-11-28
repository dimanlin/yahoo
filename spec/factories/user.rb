FactoryGirl.define do
  sequence :user_email do |n|
    "example_#{n}@gmail.com"
  end

  factory :user do
    email { FactoryGirl.generate(:user_email) }
    password 'root0000'
    password_confirmation 'root0000'
  end
end
