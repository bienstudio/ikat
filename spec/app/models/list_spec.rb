require 'spec_helper'

describe List do
  let(:list) do
    VCR.use_cassette('app/models/list/list', erb: { id: 'foobar' }) do
      create(:wants)
    end
  end

  let(:user) { list.owner }

  let(:product) do
    VCR.use_cassette('app/models/list/product', erb: { id: 'foobar' }) do
      create :product
    end
  end

  describe '#products' do
    before do
      list.add!(product, user)
    end

    it { expect(list.products).to include product }
  end

  describe '#add!' do
    let!(:product) do
      VCR.use_cassette('app/models/list/add/product', erb: { id: 'foobar' }) do
        create :product
      end
    end

    let(:addition) do
      list.add!(product, user)
    end

    it { expect(addition).to be_an_instance_of ListItem }
    it { expect(addition.list).to eql list }
    it { expect(addition.product).to eql product }
    it { expect(addition.creator).to eql user }
  end

  describe '#remove!' do
    let!(:product) do
      VCR.use_cassette('app/models/list/remove/product', erb: { id: 'foobar' }) do
        create :product
      end
    end

    let(:removal) do
      list.add!(product, user)
      list.remove!(product, user)
    end

    it { expect(removal).to eql true }
    it do
      item = ListItem.where(
        list:    list,
        product: product
      ).first

      expect(item).to be_nil
    end
  end
end
