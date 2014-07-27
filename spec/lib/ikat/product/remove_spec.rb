require 'spec_helper'

describe ProductRemove do
  let(:list) { create :collection }

  let(:product) do
    i = list.add!(create(:product), list.owner)

    i.product
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
