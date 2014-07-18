require 'spec_helper'

describe ProductRemove do
  VCR.use_cassette('lib/ikat/product/remove/list', erb: { id: 'foobar' }) do
    let(:list) { create :collection }
  end

  let(:product) do
    VCR.use_cassette('app/models/store/store', erb: { id: 'foobar' }) do
      i = list.add!(create(:product), list.owner)

      i.product
    end
  end

  context 'with permitted user' do
    let(:user) { list.owner }

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
    it { expect(action.errors).to be_nil }
  end
end
