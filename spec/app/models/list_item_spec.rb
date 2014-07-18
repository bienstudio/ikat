require 'spec_helper'

describe ListItem do
  let!(:list_item) do
    VCR.use_cassette('app/models/list_item/list_item', erb: { id: 'foobar' }) do
      create :list_item
    end
  end

  let(:list)      { list_item.list }
  let(:product)   { list_item.product }
  let(:actor)     { list_item.creator }

  let(:other)     { create :user }

  it { expect(list_item).to be_valid }

  it { expect(list_item).to validate_presence_of :list }
  it { expect(list_item).to validate_presence_of :product }
  it { expect(list_item).to validate_presence_of :created_by }

  describe '#populate_list_item_ids' do
    it { expect(product.list_item_ids).to include list_item.id }
    it { expect(list.list_item_ids).to include list_item.id }
  end

  describe '#depopulate_list_item_ids' do
    before do
      list_item.destroy
    end

    it { expect(product.list_item_ids).to_not include list_item.id }
    it { expect(list.list_item_ids).to_not include list_item.id }
  end

  describe '#add_activity' do
    let(:activity) do
      Activity.where(
        action:  :add,
        subject: product,
        target:  list,
        actor:   actor
      ).first
    end

    it { expect(activity).to be_valid }
  end

  describe '#remove_activity' do
    context 'with passed updater' do
      before do


        list_item.destroy(other)
      end

      let(:activity) do
        Activity.where(
          action:  :remove,
          subject: product,
          target:  list,
          actor:   other
        ).first
      end

      it { expect(activity).to be_valid }
    end

    context 'without passed updater' do
      before do
        list_item.destroy
      end

      let(:activity) do
        Activity.where(
          action:  :remove,
          subject: product,
          target:  list,
          actor:   actor
        ).first
      end

      it { expect(activity).to be_valid }
    end
  end
end
