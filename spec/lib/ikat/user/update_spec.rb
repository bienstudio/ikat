require 'spec_helper'

describe UserUpdate do
  let(:user) { create :user }

  context 'with permitted user' do
    let(:action) do
      UserUpdate.run(
        current_user: user,
        user: {
          id:                    user.id.to_s,
          email:                 'foo@bar.com',
          name:                  'Foobar',
          username:              'foobar',
          password:              'barfoo1',
          password_confirmation: 'barfoo1',
          avatar:                 File.open(Rails.root.join('spec/fixtures/logo.jpeg'))
        }
      )
    end

    it { expect(action.success?).to eql true }
    it { expect(action.result).to be_an_instance_of User }
    it { expect(action.result.email).to eql 'foo@bar.com' }
    it { expect(action.result.name).to eql 'Foobar' }
    it { expect(action.result.username).to eql 'foobar' }
    it { expect(action.result.password).to eql 'barfoo1' }
  end

  context 'with unpermitted user' do
    let(:other) { create :user }

    let(:action) do
      UserUpdate.run(
        current_user: other,
        user: {
          id:                    user.id.to_s,
          email:                 user.email,
          name:                  user.name,
          username:              user.username,
          password:              nil,
          password_confirmation: nil,
          avatar:                nil
        }
      )
    end

    it { expect(action.success?).to eql false }
    it { expect(action.errors.symbolic).to eql ({ 'current_user' => :unauthorized }) }
  end
end
