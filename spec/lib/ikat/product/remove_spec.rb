require 'spec_helper'

describe ProductRemove do
  VCR.use_cassette('lib/ikat/product/remove/list', erb: { id: 'foobar' }) do
    let(:list) { create :collection }
  end

  let(:product) { list.products.first }

  context 'with permitted user' do
    let(:user) { list.user }

    let(:action) do
      ProductRemove.run(
        current_user: user,
        product: product,
        list: list
      )
    end

    it { expect(action.success?).to eql true }
    it { expect(action.result).to be_an_instance_of Collection }
    it { expect(action.result.products).to_not include product }
  end
end
