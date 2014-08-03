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

  describe '#follow!' do
    context 'user' do
      let(:action) { user.follow!(other) }

      it { expect(action).to be_an_instance_of Relationship }
      it { expect(action.follower).to eql user }
      it { expect(action.followee).to eql other }
    end

    context 'store' do
      let(:store)  { create :store }
      let(:action) { user.follow!(store) }

      it { expect(action).to be_an_instance_of Relationship }
      it { expect(action.follower).to eql user }
      it { expect(action.followee).to eql store }
    end
  end

  describe '#unfollow!' do
    context 'user' do
      before do
        user.follow!(other)
      end

      let(:action) { user.unfollow!(other) }

      it { expect(action).to eql true }
    end

    context 'store' do
      before do
        user.follow!(store)
      end

      let(:store)  { create :store }
      let(:action) { user.unfollow!(store) }

      it { expect(action).to eql true }
    end
  end

  describe '#following' do
    before do
      user.follow!(other)
    end

    it { expect(user.following).to include other }
  end

  describe '#followers' do
    before do
      other.follow!(user)
    end

    it { expect(user.followers).to include other }
  end
end
