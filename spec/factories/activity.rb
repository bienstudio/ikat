FactoryGirl.define do
  factory :activity do
    trait :follow do
      action :follow

      subject { create(:user) }
      target  { subject }
      actor   { create(:user) }
    end

    trait :unfollow do
      action :unfollow

      subject { create(:user) }
      target  { subject }
      actor   { create(:user) }
    end

    trait :add do
      action :add

      subject { create(:product) }
      target  { create(:owns) }
      actor   { create(:user) }
    end

    trait :remove do
      action :remove

      subject { create(:product) }
      target  { create(:owns) }
      actor   { create(:user) }
    end
  end
end
