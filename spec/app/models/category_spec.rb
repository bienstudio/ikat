require 'spec_helper'

describe Category do
  let(:parent) { create :category }

  let(:child) do
    parent.children << create(:category)
    parent.save

    parent.children.first
  end

  it { expect(parent).to be_valid }
  it { expect(child).to be_valid }

  it { expect(parent).to validate_presence_of :name }
end
