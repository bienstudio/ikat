require 'spec_helper'

describe Store do
  let(:store) do
    VCR.use_cassette('app/models/store/store', erb: { id: 'foobar' }) do
      create :store
    end
  end

  let(:user)  { create :user }
  let(:admin) { create :user, :admin }

  before do
    VCR.insert_cassette('app/models/store/all', erb: { id: 'foobar' })
  end

  it { expect(store).to be_valid }

  it { expect(store).to validate_presence_of :name }
  it { expect(store).to validate_presence_of :domain }
  it 'expect(store).to validate_uniqueness_of :domain '

  describe '#viewable_by?' do
    it { expect(store.viewable_by?(user)).to eql true }
  end

  describe '#creatable_by?' do
    it { expect(store.creatable_by?(user)).to eql true }
  end

  describe '#updatable_by?' do
    it { expect(store.updatable_by?(user)).to eql false }
    it { expect(store.updatable_by?(admin)).to eql true }
  end

  describe '#destroyable_by?' do
    it { expect(store.destroyable_by?(user)).to eql false }
    it { expect(store.destroyable_by?(admin)).to eql true }
  end

  describe '#followers' do
    before do
      user.follow!(store)
    end

    it { expect(store.followers).to include user }
  end

  describe '#add_activity' do
    before do
      product = create(:product)

      store.products << product
      store.save
    end

    it { expect(Activity.where(action: :add, target: store).count).to eql 1 }
  end

  describe '#remove_activity' do
    before do
      product = create(:product)

      store.products << product
      store.save

      store.products.delete(store.products.first)
    end

    it { expect(Activity.where(action: :remove, target: store).count).to eql 1 }
  end

  describe '.url_to_domain' do
    it { expect(Store.url_to_domain('https://foo.everlane.com/foobar')).to eql 'foo.everlane.com' }
  end

  after do
    VCR.eject_cassette
  end
end
