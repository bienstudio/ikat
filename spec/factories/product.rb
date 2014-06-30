include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :product do
    name     'Everlane Cotton Crew in Antique'
    link     'https://www.everlane.com/collections/mens-tees/products/mens-crew-antique'
    price    '15'
    currency :usd
    photo    { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'tee.jpg'), 'image/jpg') }

    store
  end
end
