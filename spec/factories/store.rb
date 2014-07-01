FactoryGirl.define do
  factory :store do
    name        'Everlane'
    description 'Everlane makes clothing with radical transparency.'
    link        'https://www.everlane.com/'

    logo       { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'logo.jpeg'), 'image/jpeg') }
  end
end
