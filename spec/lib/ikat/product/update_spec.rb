require 'spec_helper'

describe ProductUpdate do
  let(:user)    { create :user }
  let(:product) { create :product }

  let(:action) do
    ProductUpdate.run(
      current_user: user,
      product: {
        id: product.id.to_s,
        name: 'Slim Fit Oxford',
        link: product.link,
        price: product.price.to_s,
        currency: product.currency.to_s,
        expired: false,
        category: product.category
      }
    )
  end

  it { expect(action.success?).to eql true }
  it { expect(action.result).to be_an_instance_of Product }
  it { expect(action.result.name).to eql 'Slim Fit Oxford' }
  it { expect(action.result.updater).to eql user }
end
