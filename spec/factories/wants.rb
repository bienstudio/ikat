FactoryGirl.define do
  factory :wants do
    user

    before(:create) do |wants|
      VCR.use_cassette('spec/factories/wants/products', erb: { id: 'foobar' }) do
        3.times do
          wants.products << create(:product)
        end
      end
    end
  end
end
