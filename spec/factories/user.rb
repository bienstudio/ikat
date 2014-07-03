FactoryGirl.define do
  sequence :email do |n|
    "les#{n}@getikat.com"
  end

  sequence :username do |n|
    "les#{n}"
  end

  factory :user do
    name     'Les Grossman'
    password 'ikat123456'

    email
    username

    trait :admin do
      admin true
    end
  end
end
