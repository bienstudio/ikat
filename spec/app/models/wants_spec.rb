require 'spec_helper'

describe Wants do
  let(:wants) { create :wants }
  let(:user)  { wants.owner }
  let(:other) { create :user }

  it { expect(wants).to be_valid }

  describe '#viewable_by?' do
    it { expect(wants.viewable_by?(user)).to eql true }
  end

  describe '#creatable_by?' do
    it { expect(wants.creatable_by?(user)).to eql true }
  end

  describe '#updatable_by?' do
    it { expect(wants.updatable_by?(user)).to eql true }
    it { expect(wants.updatable_by?(other)).to eql false }
  end

  describe '#destroyable_by?' do
    it { expect(wants.destroyable_by?(user)).to eql false }
  end
end
