require 'spec_helper'

describe ProductCreate do
  let(:user)     { create :user }
  let(:store)    { create :store }
  let(:category) { create :category }

  let(:action) do
    VCR.use_cassette('lib/ikat/product/create/action', erb: { id: 'foobar' }) do
      ProductCreate.run(
        current_user: user,
        product: {
          name: 'The Slim Fit Oxford',
          link: 'https://www.everlane.com/collections/mens-shirts/products/mens-oxford-lightblue',
          price: 55.0,
          currency: 'usd',
          image_url: 'https://everlane.imgix.net/i/3c98ed62_5553.jpg?w=442&h=442&q=65&dpr=2',
          store: store,
          category: category
        }
      )
    end
  end

  it { expect(action.success?).to eql true }
  it { expect(action.result).to be_an_instance_of Product }
  it { expect(action.result.name).to eql 'The Slim Fit Oxford' }
  it { expect(action.result.link).to eql 'https://www.everlane.com/collections/mens-shirts/products/mens-oxford-lightblue' }
  it { expect(action.result.price).to eql 55.0 }
  it { expect(action.result.currency).to eql :usd }
  it { expect(action.result.original_image).to eql 'https://everlane.imgix.net/i/3c98ed62_5553.jpg?w=442&h=442&q=65&dpr=2' }
  it { expect(action.result.store).to eql store }
  it { expect(action.result.category).to eql category }
  it { expect(action.result.creator).to eql user }
  it { expect(action.result.updater).to eql user }
end
