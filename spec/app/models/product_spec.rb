require 'spec_helper'

describe Product do
  let(:product) do
    VCR.use_cassette('app/models/product/product', erb: { id: 'foobar' }) do
      create :product
    end
  end

  let(:user)  { create :user }
  let(:admin) { create :user, :admin }

  before do
    VCR.insert_cassette('app/models/product/all', erb: { id: 'foobar' })
  end

  it { expect(product).to be_valid }

  it { expect(product).to validate_presence_of :name }
  it { expect(product).to validate_presence_of :link }
  it { expect(product).to validate_presence_of :price }
  it { expect(product).to validate_presence_of :currency }
  it { expect(product).to validate_presence_of :category }
  it { expect(product).to validate_presence_of :original_image }

  it 'expect(product).to validate_attachment_presence :photo' # Waiting on Paperclip to not use deprecated RSpec matchers
  it { expect(product).to validate_attachment_content_type(:photo).allowing('image/jpg', 'image/jpeg', 'image/png', 'image/gif').rejecting('text/xml', 'text/html') }

  describe '#viewable_by?' do
    it { expect(product.viewable_by?(user)).to eql true }
  end

  describe '#creatable_by?' do
    it { expect(product.creatable_by?(user)).to eql true }
  end

  describe '#updatable_by?' do
    it { expect(product.updatable_by?(user)).to eql true }
  end

  describe '#destroyable_by?' do
    it { expect(product.destroyable_by?(user)).to eql false }
    it { expect(product.destroyable_by?(admin)).to eql true }
  end

  describe '#create_slug!' do
    it { expect(product.slug).to eql 'everlane-cotton-crew-in-antique' }
  end

  after do
    VCR.eject_cassette
  end
end
