require 'spec_helper'

describe ProductDestroy do
  let(:product) { create :product }

  context 'with permitted user' do
    let(:user) { create :user, :admin }

    let(:action) do
      ProductDestroy.run(
        current_user: user,
        product: {
          id: product.id.to_s
        }
      )
    end

    it { expect(action.success?).to eql true }
    it { expect(action.result).to be_nil }
  end

  context 'with unpermitted user' do
    let(:user) { create :user }

    let(:action) do
      ProductDestroy.run(
        current_user: user,
        product: {
          id: product.id.to_s
        }
      )
    end

    it { expect(action.success?).to eql false }
    it { expect(action.errors.symbolic).to eql ({ 'current_user' => :unauthorized }) }
  end
end
