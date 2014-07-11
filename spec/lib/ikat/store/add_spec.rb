require 'spec_helper'

describe StoreAdd do
  let(:user) { create :user }

  context 'existing store' do
    let!(:store) { create :store }

    let(:action) do
      StoreAdd.run(
        current_user: user,
        store: {
          url: "http://#{store.domain}/foobar"
        }
      )
    end

    it { expect(action.success?).to eql true }
    it { expect(action.result).to be_an_instance_of Store }
    it { expect(action.result).to eql store }
  end

  context 'non-existing store' do
    let(:action) do
      StoreAdd.run(
        current_user: user,
        store: {
          url: 'http://everlane.com'
        }
      )
    end

    it { expect(action.success?).to eql true }
    it { expect(action.result).to be_an_instance_of Store }
    it { expect(action.result.domain).to eql 'everlane.com' }
  end
end
