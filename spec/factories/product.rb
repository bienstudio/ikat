FactoryGirl.define do
  sequence :original_image do |n|
    "https://everlane.imgix.net/i/ba1e1a73_723e.jpg?w=442&h=442&q=65&dpr=#{n}"
  end

  factory :product do
    name     'Everlane Cotton Crew in Antique'
    link     'https://www.everlane.com/collections/mens-tees/products/mens-crew-antique'
    price    15.0
    currency :usd
    photo    { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'tee.jpg'), 'image/jpg') }

    original_image

    category
    store
  end
end
