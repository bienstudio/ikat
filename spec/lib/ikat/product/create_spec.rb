require 'spec_helper'

describe ProductCreate do
  let(:user) { create :user }

  let(:action) do
    VCR.use_cassette('lib/ikat/product/create/product_create', erb: { id: 'foobar' }) do
      ProductCreate.run(
        current_user: user,
        product: {
          name:     'Everlane Cotton Crew in Antique',
          link:     'https://www.everlane.com/collections/mens-tees/products/mens-crew-antique',
          price:    15.0,
          currency: :usd,
          photo:    'https://everlane.imgix.net/i/ba1e1a73_723e.jpg?w=442&h=442&q=65&dpr=2'
        }
      )
    end
  end

  it { expect(action.success?).to eql true }
  it { expect(action.result).to be_an_instance_of Product }
  it { expect(action.result.store).to eql store }
end
