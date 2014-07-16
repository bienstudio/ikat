require 'spec_helper'

describe List do
  let(:list) do
    @w = create :wants

    VCR.use_cassette('app/models/list/product', erb: { id: 'foobar' }) do
      @w.products << create(:product)
      @w.save
    end

    @w
  end

  describe '#create_activity' do
    it { expect(Activity.where(action: :add, target: list).count).to be > 1 }
  end

  describe '#remove_activity' do
    before do
      list.products.delete(list.products.first)
      list.save
    end

    it { expect(Activity.where(action: :remove, target: list).count).to eql 1 }
  end
end
