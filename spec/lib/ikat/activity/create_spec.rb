require 'spec_helper'

describe ActivityCreate do
  let(:list_item) { create :list_item }

  let(:action) do
    ActivityCreate.run(
      current_user: list_item.list.owner,
      activity: {
        action: :click,
        subject: list_item.product,
        target: list_item.list,
        actor: list_item.list.owner
      }
    )
  end

  it { expect(action.success?).to eql true }
  it { expect(action.result).to be_an_instance_of Activity }
  it { expect(action.result.action).to eql :click }
end
