require 'spec_helper'

describe ProductAdd do
  let(:user) { create :user }

  context 'non-existant product or store' do
    let(:action) do
      @a = VCR.use_cassette('lib/ikat/product/add/product_add1', erb: { id: 'foobar' }) do
        ProductAdd.run(
          current_user: user,
          product: {
            url: 'https://www.everlane.com/collections/mens-tees/products/mens-crew-antique',
            photo_url: 'https://everlane.imgix.net/i/ba1e1a73_723e.jpg?w=442&h=442&q=65&dpr=2',
            title: 'The Men’s Crew - Antique  – Everlane',
            price: '$15',
            list: user.wanted
          }
        )
      end

      user.reload

      @a
    end

    it { expect(action.success?).to eql true }
    it { expect(action.result).to be_an_instance_of Product }
    it { expect(action.result.name).to eql 'The Men’s Crew - Antique  – Everlane' }
    it { expect(action.result.link).to eql 'https://www.everlane.com/collections/mens-tees/products/mens-crew-antique' }
    it { expect(action.result.price).to eql 15.0 }
    it { expect(action.result.currency).to eql :usd }
    it { expect(action.result.store).to be_an_instance_of Store }
    it { expect(action.result.store.name).to eql 'Everlane' }
    it { expect(action.result.store.link).to eql 'https://www.everlane.com' }
    it { expect(user.wanted.products).to include action.result }
  end

  context 'non-existant product with existing store' do
    let(:store) do
      VCR.use_cassette('lib/ikat/product/add/store1', erb: { id: 'foobar' }) do
        create :store
      end
    end

    let(:action) do
      @a = VCR.use_cassette('lib/ikat/product/add/product_add2', erb: { id: 'foobar' }) do
        ProductAdd.run(
          current_user: user,
          product: {
            url: 'https://www.everlane.com/collections/mens-tees/products/mens-crew-antique',
            photo_url: 'https://everlane.imgix.net/i/ba1e1a73_723e.jpg?w=442&h=442&q=65&dpr=2',
            title: 'The Men’s Crew - Antique  – Everlane',
            price: '$15',
            list: user.wanted
          }
        )
      end

      user.reload

      @a
    end

    it { expect(action.success?).to eql true }
    it { expect(action.result).to be_an_instance_of Product }
    it { expect(action.result.name).to eql 'The Men’s Crew - Antique  – Everlane' }
    it { expect(action.result.link).to eql 'https://www.everlane.com/collections/mens-tees/products/mens-crew-antique' }
    it { expect(action.result.price).to eql 15.0 }
    it { expect(action.result.currency).to eql :usd }
    it { expect(action.result.store).to eql store }
    it { expect(user.wanted.products).to include action.result }
  end

  context 'existing product and store' do
    context 'no new information' do
      let(:product) do
        VCR.use_cassette('lib/ikat/product/add/product1', erb: { id: 'foobar' }) do
          create :product
        end
      end

      let(:action) do
        @a = VCR.use_cassette('lib/ikat/product/add/product_add3', erb: { id: 'foobar' }) do
          ProductAdd.run(
            current_user: user,
            product: {
              url: 'https://www.everlane.com/collections/mens-tees/products/mens-crew-antique',
              photo_url: 'https://everlane.imgix.net/i/ba1e1a73_723e.jpg?w=442&h=442&q=65&dpr=2',
              title: 'The Men’s Crew - Antique  – Everlane',
              price: '$15',
              list: user.wanted
            }
          )
        end

        user.reload

        @a
      end

      it { expect(action.success?).to eql true }
      it { expect(action.result).to eql product }
      it { expect(action.result.store).to eql product.store }
      it { expect(user.wanted.products).to include action.result }
    end

    context 'new information' do
      let(:product) do
        VCR.use_cassette('lib/ikat/product/add/product2', erb: { id: 'foobar' }) do
          create :product
        end
      end

      let(:action) do
        @a = VCR.use_cassette('lib/ikat/product/add/product_add4', erb: { id: 'foobar' }) do
          ProductAdd.run(
            current_user: user,
            product: {
              url: 'https://www.everlane.com/collections/mens-tees/products/mens-crew-antique',
              photo_url: 'https://everlane.imgix.net/i/ba1e1a73_723e.jpg?w=442&h=442&q=65&dpr=2',
              title: 'The Men’s Crew - Antique  – Everlane',
              price: '$20',
              list: user.wanted
            }
          )
        end

        user.reload

        @a
      end

      it { expect(action.success?).to eql true }
      it { expect(action.result).to eql product }
      it { expect(action.result.price).to eql 20.0 }
      it { expect(action.result.store).to eql product.store }
      it { expect(user.wanted.products).to include action.result }
    end
  end
end
