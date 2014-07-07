require 'spec_helper'

describe Activity do
  let(:follow)   { create :activity, :follow }
  let(:unfollow) { create :activity, :unfollow }

  let(:add) do
    VCR.use_cassette('app/models/activity/add', erb: { id: 'foobar' }) do
      create :activity, :add
    end
  end

  let(:remove) do
    VCR.use_cassette('app/models/activity/remove', erb: { id: 'foobar' }) do
      create :activity, :remove
    end
  end

  it { expect(follow).to be_valid }
  it { expect(unfollow).to be_valid }
  it { expect(add).to be_valid }
  it { expect(remove).to be_valid }

  # Just testing the Mongo criteria for now
  describe '#feed' do
    let(:feed) { Activity.feed(follow.actor, [:follow, :unfollow, :add, :remove]) }

    it { expect(feed).to be_an_instance_of Mongoid::Criteria }
  end
end
