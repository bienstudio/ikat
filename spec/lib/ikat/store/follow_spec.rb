require 'spec_helper'

describe StoreFollow do
  let(:follower) { create :user }
  let(:followee) { create :store }

  let(:action) do
    StoreFollow.run(
      current_user: follower,
      store: {
        id: followee.id.to_s
      }
    )
  end

  it { expect(action.success?).to eql true }
  it { expect(action.result).to be_an_instance_of Relationship }
  it { expect(action.result.follower).to eql follower }
  it { expect(action.result.followee).to eql followee }

  it { expect(action.errors).to be_nil }
end
