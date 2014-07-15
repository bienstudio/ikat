class ProductCreate < IkatMutation
  required do
    model :current_user, class: User
    hash  :product do
      string :name
      string :link
      float  :price
      string :currency
      string :image_url
      model  :store
      model  :category
    end
  end

  def execute
    product['original_image'] = product['image_url']
    product['photo'] = product['image_url']
    product.delete('image_url')

    p = Product.new(product)
    p.creator = current_user
    p.updater = current_user
    p.save

    mongoid_errors!(p)

    p
  end
end
