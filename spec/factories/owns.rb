FactoryGirl.define do
  factory :owns do
    user

    before(:create) do |owns|
      VCR.use_cassette('spec/factories/owns/products', erb: { id: 'foobar' }) do
        3.times do
          owns.products << create(:product)
        end
      end
    end
  end
end
