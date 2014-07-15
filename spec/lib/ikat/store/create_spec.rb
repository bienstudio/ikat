require 'spec_helper'

describe StoreCreate do
  let(:user) { create :user }

  let(:action) do
    StoreCreate.run(
      current_user: user,
      store: {
        name: 'J.Crew',
        description: '',
        domain: 'jcrew.com'
      }
    )
  end

  it { expect(action.success?).to eql true }
  it { expect(action.result).to be_an_instance_of Store }
  it { expect(action.result.name).to eql 'J.Crew' }
  it { expect(action.result.description).to be_blank }
  it { expect(action.result.domain).to eql 'jcrew.com' }
  it { expect(action.result.creator).to eql user }
  it { expect(action.result.updater).to eql user }
end
