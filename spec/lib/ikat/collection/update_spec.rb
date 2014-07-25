require 'spec_helper'

describe CollectionUpdate do
  let(:collection) { create :collection }

  context 'with permitted user' do
    let(:user) { collection.owner }

    let(:action) do
      CollectionUpdate.run(
        current_user: user,
        collection: {
          id:     collection.id.to_s,
          name:   collection.name,
          hidden: true
        }
      )
    end

    it { expect(action.success?).to eql true }
    it { expect(action.result).to be_an_instance_of Collection }
    it { expect(action.result.hidden).to eql true }
  end

  context 'with unpermitted user' do
    let(:user) { create :user }

    let(:action) do
      CollectionUpdate.run(
        current_user: user,
        collection: {
          id:     collection.id.to_s,
          name:   collection.name,
          hidden: true
        }
      )
    end

    it { expect(action.success?).to eql false }
    it { expect(action.errors.symbolic).to eql ({ 'current_user' => :unauthorized }) }
  end
end
