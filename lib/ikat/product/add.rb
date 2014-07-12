class ProductAdd < IkatMutation
  required do
    model :current_user, class: User
    hash  :product do
      string :name
      string :price
      string :currency
      string :url
      string :image_url
      model  :category
    end
    model :list
  end

  def execute
    # First check for existing products
    if p = Product.where(original_image: product['image_url']).first
      list.products << p
      list.save

      return p
    end

    # If not, create add the store and new product
    p = Product.new(
      name: product['name'],
      link: product['url'],
      price: product['price'],
      currency: product['currency'],
      photo: product['image_url'],
      original_image: product['image_url']
    )

    p.category = product['category']

    store = StoreAdd.run(
      current_user: current_user,
      store: {
        url: product['url']
      }
    )

    p.store = store.result

    p.save

    mongoid_errors!(p)

    list.products << p
    list.save

    mongoid_errors!(list)

    return p
  end
end
