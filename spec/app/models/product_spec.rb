require 'spec_helper'

describe Product do
  let(:product) do
    @p = Product.new
    @p.name = 'Cotton Tee'
    @p.link = 'https://google.com'
    @p.price = 10.0
    @p.currency = :usd

    VCR.use_cassette('product', erb: { id: @p.id }, match_requests_on: [:host]) do
      @p.photo = File.open(Rails.root.join('spec/fixtures/tee.jpg'))
      @p.save
    end

    @p
  end

  it { expect(product).to be_valid }

  it { expect(product).to validate_presence_of :name }
  it { expect(product).to validate_presence_of :link }
  it { expect(product).to validate_presence_of :price }
  it { expect(product).to validate_presence_of :currency }

  # it { expect(product).to have_attached_file :photo }
  # it { expect(product).to validate_attachment_presence :photo }
  # it { expect(product).to validate_attachment_content_type(:photo).allowing('image/jpg', 'image/jpeg', 'image/png', 'image/gif').rejecting('text/xml', 'text/html') }
end
