require 'spec_helper'

describe StoreUpdate do
  let(:store) { create :store }

  context 'with permitted user' do
    let(:user) { create :user, :admin }
    let(:action) do
      StoreUpdate.run(
        current_user: user,
        store: {
          id: store.id.to_s,
          name: store.name,
          description: store.description,
          domain: 'needsupply.com'
        }
      )
    end

    it { expect(action.success?).to eql true }
    it { expect(action.result).to be_an_instance_of Store }
    it { expect(action.result.domain).to eql 'needsupply.com' }
    it { expect(action.result.updater).to eql user }
  end

  context 'with unpermitted user' do
    let(:user) { create :user }
    let(:action) do
      StoreUpdate.run(
        current_user: user,
        store: {
          id: store.id.to_s,
          name: store.name,
          description: store.description,
          domain: 'needsupply.com'
        }
      )
    end

    it { expect(action.success?).to eql false }
    it { expect(action.errors.symbolic).to eql ({ 'current_user' => :unauthorized }) }
  end
end
