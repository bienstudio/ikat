require 'spec_helper'

describe Relationship do
  context 'follow' do
    context 'user' do
      let(:relationship) { create :relationship, :user }

      it { expect(relationship).to be_valid }

      it { expect(relationship).to validate_presence_of :follower }
      it { expect(relationship).to validate_presence_of :followee }

      it do
        activity = Activity.where(
          action:  :follow,
          subject: relationship.followee,
          target:  relationship.followee,
          actor:   relationship.follower
        ).first

        expect(activity).to be_valid
      end

      describe '#following' do
        it { expect(Relationship.following(relationship.follower)).to include relationship }
      end

      describe '#followers' do
        it { expect(Relationship.followers(relationship.followee)).to include relationship }
      end
    end

    context 'store' do
      let(:relationship) do
        VCR.use_cassette('app/models/relationship/store', erb: { id: 'foobar' }) do
          create :relationship, :store
        end
      end

      it { expect(relationship).to be_valid }

      it { expect(relationship).to validate_presence_of :follower }
      it { expect(relationship).to validate_presence_of :followee }

      it do
        activity = Activity.where(
          action:  :follow,
          subject: relationship.followee,
          target:  relationship.followee,
          actor:   relationship.follower
        ).first

        expect(activity).to be_valid
      end
    end
  end

  context 'unfollow' do
    let(:relationship) { create :relationship, :user }

    before do
      relationship.destroy
    end

    it do
      activity = Activity.where(
        action:  :unfollow,
        subject: relationship.followee,
        target:  relationship.followee,
        actor:   relationship.follower
      ).first

      expect(activity).to be_valid
    end
  end
end
