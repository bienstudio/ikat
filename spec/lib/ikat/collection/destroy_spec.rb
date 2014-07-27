require 'spec_helper'

describe CollectionUpdate do
  let(:collection) { create :collection }

  context 'with permitted user' do
    let(:user) { collection.owner }

    let(:action) do
      CollectionDestroy.run(
        current_user: user,
        collection: {
          id: collection.id.to_s,
        }
      )
    end

    it { expect(action.success?).to eql true }
    it { expect(action.result).to be_nil }
  end

  context 'with unpermitted user' do
    let(:user) { create :user }

    let(:action) do
      CollectionDestroy.run(
        current_user: user,
        collection: {
          id: collection.id.to_s,
        }
      )
    end

    it { expect(action.success?).to eql false }
    it { expect(action.errors.symbolic).to eql ({ 'current_user' => :unauthorized }) }
  end
end
