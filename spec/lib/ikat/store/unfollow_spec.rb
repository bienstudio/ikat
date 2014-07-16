require 'spec_helper'

describe StoreUnfollow do
  let(:relationship) { create :relationship, :store }
  let(:follower)     { relationship.follower }
  let(:followee)     { relationship.followee }
  let(:other)        { create :user }

  context 'with permitted user' do
    let(:action) do
      StoreUnfollow.run(
        current_user: follower,
        store: {
          id: followee.id.to_s
        }
      )
    end

    it { expect(action.success?).to eql true }
    it { expect(action.result).to be_nil }
  end

  context 'with unpermitted user' do
    let(:action) do
      StoreUnfollow.run(
        current_user: other,
        store: {
          id: followee.id.to_s
        }
      )
    end

    it { expect(action.success?).to eql false }
    it { expect(action.errors.symbolic).to eql ({ 'current_user' => :unauthorized }) }
  end
end
