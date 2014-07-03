require 'spec_helper'

describe UserCreate do
  let(:action) do
    UserCreate.run(
      user: {
        email:                 'mor@getikat.com',
        name:                  'Mor Grossman',
        username:              'mor',
        password:              '1234ikat',
        password_confirmation: '1234ikat'
      }
    )
  end

  it { expect(action.success?).to eql true }
  it { expect(action.result).to be_an_instance_of User }
end
