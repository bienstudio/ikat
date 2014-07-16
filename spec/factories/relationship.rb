FactoryGirl.define do
  factory :relationship do
    follower { create(:user) }

    trait :user do
      followee { create(:user) }
    end

    trait :store do
      followee { create(:store) }
    end
  end
end
