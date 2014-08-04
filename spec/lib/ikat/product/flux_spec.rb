require 'spec_helper'

describe ProductFlux do
  context 'add' do
    let(:list)    { create :wants }
    let(:user)    { list.owner }
    let(:product) { create :product }

    let(:action) do
      ProductFlux.run(
        current_user: user,
        list: list,
        product: product
      )
    end

    it { expect(action.success?).to eql true }
    it { expect(action.result).to be_an_instance_of Array }
    it { expect(action.result.first).to be_an_instance_of Product }
    it { expect(action.result.last).to be_an_instance_of ListItem }
    it { expect(action.result.last.product).to eql product }
    it { expect(action.result.last.list).to eql list }
  end

  context 'remove' do
    let(:list_item) { create :list_item }
    let(:list)      { list_item.list }
    let(:user)      { list.owner }
    let(:product)   { list_item.product }

    let(:action) do
      ProductFlux.run(
        current_user: user,
        list: list,
        product: product
      )
    end

    it { expect(action.success?).to eql true }
    it { expect(action.result).to be_an_instance_of Array }
    it { expect(action.result.first).to be_an_instance_of Product }
    it { expect(action.result.last).to be_nil }
  end
end
