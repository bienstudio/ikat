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
      p.update_attributes(
        name: product['name'],
        link: product['url'],
        price: product['price'],
        currency: product['currency']
      )

      mongoid_errors!(p)

      p.save

      # i = list.add!(p, current_user)
      add_to_list!(list, p, current_user)

      mongoid_errors!(list)

      return p
    end

    # If not, create add the store and new product
    p = Product.new(
      name: product['name'],
      link: product['url'],
      price: product['price'],
      currency: product['currency'],
      photo: product['image_url'],
      original_image: product['image_url'],
      remote_photo_url: product['image_url']
    )

    p.category = product['category']

    store = StoreAdd.run(
      current_user: current_user,
      store: {
        url: product['url']
      }
    ).result

    p.store_id = store.id

    mongoid_errors!(p)

    p.save

    add_to_list!(store.inventory, p, store) # the store itself is adding the product

    add_to_list!(list, p, current_user)

    return p
  end

  def add_to_list!(l, p, u)
    if i = ListItem.where(product: p, list: l).first
      return i
    end

    return l.add!(p, u)
  end
end
