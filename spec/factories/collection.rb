FactoryGirl.define do
  factory :collection do
    name 'Purchase'

    owner { create(:user) }

    # before(:create) do |collection|
    #   VCR.use_cassette('spec/factories/collection/products', erb: { id: 'foobar' }) do
    #     3.times do
    #       collection.list_items << create(:list_item, list: collection, created_by: collection.owner.id)
    #     end
    #   end
    # end

    trait :hidden do
      hidden true
    end
  end
end
