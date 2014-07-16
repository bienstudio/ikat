require 'spec_helper'

describe CollectionCreate do
  let(:user) { create :user }
  let(:action) do
    CollectionCreate.run(
      current_user: user,
      collection: {
        name:   'Purchase',
        hidden: true
      }
    )
  end

  it { expect(action.success?).to eql true }
  it { expect(action.result).to be_an_instance_of Collection }
  it { expect(action.result.name).to eql 'Purchase' }
  it { expect(action.result.hidden).to eql true }
end
