class ProductFlux < IkatMutation
  required do
    model :current_user, class: User
    model :product
    model :list
  end

  def execute
    if list_item = ListItem.where(product: product, list: list).first
      list.remove!(product)
    else
      list.add!(product)
    end
  end
end
