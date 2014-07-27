require 'spec_helper'

describe Store do
  let(:store) { create :store }
  let(:user)  { create :user }
  let(:admin) { create :user, :admin }

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

  describe '.domain_from_url' do
    it { expect(Store.domain_from_url('https://foo.everlane.com/foobar')).to eql 'foo.everlane.com' }
  end

  describe '#create_inventory!' do
    it { expect(store.inventory).to be_an_instance_of Inventory }
  end
end
