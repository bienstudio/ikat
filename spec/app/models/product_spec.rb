require 'spec_helper'

describe Product do
  let(:product) do
    VCR.use_cassette('app/models/product/product', erb: { id: 'foobar' }) do
      create :product
    end
  end

  before do
    VCR.insert_cassette('app/models/product/all', erb: { id: 'foobar' })
  end

  it { expect(product).to be_valid }

  it { expect(product).to validate_presence_of :name }
  it { expect(product).to validate_presence_of :link }
  it { expect(product).to validate_presence_of :price }
  it { expect(product).to validate_presence_of :currency }

  it 'expect(product).to validate_attachment_presence :photo' # Waiting on Paperclip to not use deprecated RSpec matchers
  it { expect(product).to validate_attachment_content_type(:photo).allowing('image/jpg', 'image/jpeg', 'image/png', 'image/gif').rejecting('text/xml', 'text/html') }

  after do
    VCR.eject_cassette
  end
end
