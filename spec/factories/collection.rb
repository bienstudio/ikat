FactoryGirl.define do
  factory :collection do
    name 'Purchase'

    user

    before(:create) do |collection|
      VCR.use_cassette('spec/factories/collection/products', erb: { id: 'foobar' }) do
        3.times do
          collection.products << create(:product)
        end
      end
    end

    trait :hidden do
      hidden true
    end
  end
end
