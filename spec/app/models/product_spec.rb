require 'spec_helper'

describe Product do
  let(:product) { create :product }

  let(:user)  { create :user }
  let(:admin) { create :user, :admin }

  it { expect(product).to be_valid }

  it { expect(product).to validate_presence_of :name }
  it { expect(product).to validate_presence_of :link }
  it { expect(product).to validate_presence_of :price }
  it { expect(product).to validate_presence_of :currency }
  it { expect(product).to validate_presence_of :category }
  it { expect(product).to validate_presence_of :original_image }

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
end
