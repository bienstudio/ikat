FactoryGirl.define do
  factory :relationship do
    followee { create(:user) }

    trait :user do
      follower { create(:user) }
    end

    trait :store do
      follower { create(:store) }
    end
  end
end
