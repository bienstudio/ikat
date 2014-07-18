FactoryGirl.define do
  factory :owns do
    owner { create(:user) }

    # before(:create) do |owns|
    #   VCR.use_cassette('spec/factories/owns/products', erb: { id: 'foobar' }) do
    #     3.times do
    #       owns.list_items << create(:list_item, list: owns, created_by: owns.owner.id)
    #     end
    #   end
    # end
  end
end
