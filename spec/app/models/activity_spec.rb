require 'spec_helper'

describe Activity do
  let(:follow)   { create :activity, :follow }
  let(:unfollow) { create :activity, :unfollow }

  let(:add) { create :activity, :add }
  let(:remove) { create :activity, :remove }

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
