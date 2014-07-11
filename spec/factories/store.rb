FactoryGirl.define do
  sequence :domain do |n|
    "everlane#{n}.com"
  end

  factory :store do
    name        'Everlane'
    description 'Everlane makes clothing with radical transparency.'

    domain

    # logo       { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'logo.jpeg'), 'image/jpeg') }
  end
end
