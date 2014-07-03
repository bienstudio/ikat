require 'spec_helper'

describe User do
  let(:user)  { create :user }
  let(:admin) { create :user, :admin }
  let(:other) { create :user }

  it { expect(user).to be_valid }

  it { expect(user).to validate_presence_of :name }
  it { expect(user).to validate_presence_of :email }
  it { expect(user).to validate_presence_of :username }

  it { expect(user).to validate_uniqueness_of :email }
  it { expect(user).to validate_uniqueness_of :username }

  describe '#create_lists!' do
    it { expect(user.wants).to be_an_instance_of Wants }
    it { expect(user.owns).to be_an_instance_of Owns }
  end

  describe '#viewable_by?' do
    it { expect(user.viewable_by?(user)).to eql true }
  end

  describe '#creatable_by?' do
    it { expect(user.creatable_by?(user)).to eql true }
  end

  describe '#updatable_by?' do
    it { expect(user.updatable_by?(user)).to eql true }
    it { expect(user.updatable_by?(admin)).to eql true }
    it { expect(user.updatable_by?(other)).to eql false }
  end

  describe '#destroyable_by?' do
    it { expect(user.destroyable_by?(user)).to eql true }
    it { expect(user.destroyable_by?(admin)).to eql true }
    it { expect(user.destroyable_by?(other)).to eql false }
  end
end
