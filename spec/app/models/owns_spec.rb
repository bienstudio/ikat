require 'spec_helper'

describe Owns do
  let(:owns)  { create :owns }
  let(:user)  { owns.owner }
  let(:other) { create :user }

  it { expect(owns).to be_valid }

  describe '#viewable_by?' do
    it { expect(owns.viewable_by?(user)).to eql true }
  end

  describe '#creatable_by?' do
    it { expect(owns.creatable_by?(user)).to eql true }
  end

  describe '#updatable_by?' do
    it { expect(owns.updatable_by?(user)).to eql true }
    it { expect(owns.updatable_by?(other)).to eql false }
  end

  describe '#destroyable_by?' do
    it { expect(owns.destroyable_by?(user)).to eql false }
  end
end
