class ProductUpdate < IkatMutation
  required do
    model :current_user, class: User
    hash  :product do
      string  :id
      string  :name
      string  :link
      string  :price
      string  :currency
      boolean :expired
      string  :original_image
      model   :photo, class: Paperclip::Attachment
      model   :category
    end
  end

  def execute
    p = Product.find(product['id'])
    p.update_attributes(product)
    p.updater = current_user
    p.save

    p
  end
end
