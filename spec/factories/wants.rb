FactoryGirl.define do
  factory :wants do
    owner { create(:user) }
    
    # before(:create) do |wants|
    #   VCR.use_cassette('spec/factories/wants/products', erb: { id: 'foobar' }) do
    #     3.times do
    #       wants.list_items << create(:list_item, list: wants, created_by: wants.owner.id)
    #     end
    #   end
    # end
  end
end
