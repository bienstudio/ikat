require 'spec_helper'

describe ProductUpdate do
  let(:user)    { create :user }
  let(:product) do
    VCR.use_cassette('lib/ikat/product/update/product', erb: { id: 'foobar' }) do
      create :product
    end
  end

  let(:action) do
    VCR.use_cassette('lib/ikat/product/update/action', erb: { id: 'foobar' }) do
      ProductUpdate.run(
        current_user: user,
        product: {
          id: product.id.to_s,
          name: 'Slim Fit Oxford',
          link: product.link,
          price: product.price.to_s,
          currency: product.currency.to_s,
          expired: false,
          original_image: product.original_image,
          photo: product.photo,
          store: product.store,
          category: product.category
        }
      )
    end
  end

  it { expect(action.success?).to eql true }
  it { expect(action.result).to be_an_instance_of Product }
  it { expect(action.result.name).to eql 'Slim Fit Oxford' }
  it { expect(action.result.updater).to eql user }
end
