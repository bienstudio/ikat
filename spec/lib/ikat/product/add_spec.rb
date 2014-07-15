require 'spec_helper'

describe ProductAdd do
  let(:user)     { create :user }
  let(:category) { create :category }

  context 'existing product' do
    let!(:product) do
      VCR.use_cassette('lib/ikat/product/add/existing/product', erb: { id: 'foobar' }) do
        create :product
      end
    end

    let(:action) do
      ProductAdd.run(
        current_user: user,
        product: {
          name: product.name,
          price: '20',
          currency: product.currency.to_s,
          url: product.link,
          image_url: product.original_image,
          category: product.category
        },
        list: user.wants
      )
    end

    it { expect(action.success?).to eql true }
    it { expect(action.result).to be_an_instance_of Product }
    it { expect(action.result).to eql product }
    it { expect(action.result.price).to eql 20.0 }
    it { expect(user.wants.products).to include action.result }
  end

  context 'non-existing product' do
    context 'existing store' do
      let!(:store) do
        create :store
      end

      let(:action) do
        VCR.use_cassette('lib/ikat/product/add/non-existing/existing/action', erb: { id: 'foobar' }) do
          ProductAdd.run(
            current_user: user,
            product: {
              name: 'Men\'s Crew Antique',
              price: '20',
              currency: 'usd',
              url: "https://#{store.domain}/collections/mens-tees/products/mens-crew-antique",
              image_url: 'https://everlane.imgix.net/i/ba1e1a73_723e.jpg?w=442&h=442&q=65&dpr',
              category: category
            },
            list: user.wants
          )
        end
      end

      it { expect(action.success?).to eql true }
      it { expect(action.result).to be_an_instance_of Product }
      it { expect(action.result.name).to eql 'Men\'s Crew Antique' }
      it { expect(action.result.price).to eql 20.0 }
      it { expect(action.result.currency).to eql :usd }
      it { expect(action.result.photo.url).to_not be_nil }
      it { expect(action.result.store).to eql store }
      it { expect(action.result.category).to eql category }
      it { expect(user.wants.products).to include action.result }
    end

    context 'non-existing store' do
      let(:action) do
        VCR.use_cassette('lib/ikat/product/add/non-existing/non-existing/action', erb: { id: 'foobar' }) do
          ProductAdd.run(
            current_user: user,
            product: {
              name: 'Men\'s Crew Antique',
              price: '20',
              currency: 'usd',
              url: "https://www.everlane.com/collections/mens-tees/products/mens-crew-antique",
              image_url: 'https://everlane.imgix.net/i/ba1e1a73_723e.jpg?w=442&h=442&q=65&dpr',
              category: category
            },
            list: user.wants
          )
        end
      end

      it { expect(action.success?).to eql true }
      it { expect(action.result).to be_an_instance_of Product }
      it { expect(action.result.name).to eql 'Men\'s Crew Antique' }
      it { expect(action.result.price).to eql 20.0 }
      it { expect(action.result.currency).to eql :usd }
      it { expect(action.result.photo.url).to_not be_nil }
      it { expect(action.result.store).to be_an_instance_of Store }
      it { expect(action.result.store.domain).to eql 'everlane.com' }
      it { expect(action.result.category).to eql category }
      it { expect(user.wants.products).to include action.result }
    end
  end
end
