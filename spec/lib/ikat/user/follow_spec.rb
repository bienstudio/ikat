require 'spec_helper'

describe UserFollow do
  let(:follower) { create :user }
  let(:followee) { create :user }

  let(:action) do
    UserFollow.run(
      current_user: follower,
      user: {
        id: followee.id.to_s
      }
    )
  end

  it { expect(action.success?).to eql true }
  it { expect(action.result).to be_an_instance_of Relationship }
  it { expect(action.result.follower).to eql follower }
  it { expect(action.result.followee).to eql followee }
end
