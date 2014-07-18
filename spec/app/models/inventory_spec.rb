require 'spec_helper'

describe Inventory do
  let(:inventory) { create :inventory }
  let(:store)     { inventory.owner }
  let(:admin)     { create :user, :admin }
  let(:user)      { create :user }

  it { expect(inventory).to be_valid }

  describe '#viewable_by?' do
    it { expect(inventory.viewable_by?(user)).to eql true }
  end

  describe '#creatable_by?' do
    it { expect(inventory.creatable_by?(user)).to eql true }
  end

  describe '#updatable_by?' do
    it { expect(inventory.updatable_by?(user)).to eql true }
  end

  describe '#destroyable_by?' do
    it { expect(inventory.destroyable_by?(user)).to eql false }
  end
end
