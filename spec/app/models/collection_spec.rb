require 'spec_helper'

describe Collection do
  VCR.use_cassette('app/models/collection/collection', erb: { id: 'foobar' }) do
    let(:collection) { create :collection }
  end

  VCR.use_cassette('app/models/collection/collection_hidden', erb: { id: 'foobar' }) do
    let(:hidden) { create :collection, :hidden }
  end

  let(:user)  { collection.owner }
  let(:other) { create :user }

  it { expect(collection).to be_valid }

  it { expect(collection).to validate_presence_of :name }

  describe '#viewable_by?' do
    context 'when public' do
      let(:user)  { collection.owner }
      let(:other) { create :user }

      it { expect(collection.viewable_by?(user)).to eql true }
      it { expect(collection.viewable_by?(other)).to eql true }
    end

    context 'when hidden' do
      let(:user)  { hidden.owner }
      let(:other) { create :user }

      it { expect(hidden.viewable_by?(user)).to eql true }
      it { expect(hidden.viewable_by?(other)).to eql false }
    end
  end

  describe '#creatable_by?' do
    it { expect(collection.creatable_by?(user)).to eql true }
  end

  describe '#updatable_by?' do
    it { expect(collection.updatable_by?(user)).to eql true }
    it { expect(collection.updatable_by?(other)).to eql false }
  end

  describe '#destroyable_by?' do
    it { expect(collection.destroyable_by?(user)).to eql true }
    it { expect(collection.destroyable_by?(other)).to eql false }
  end
end
