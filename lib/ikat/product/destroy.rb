class ProductDestroy < IkatMutation
  required do
    model :current_user, class: User
    hash  :product do
      string :id
    end
  end

  def execute
    p = Product.find(product['id'])

    unless current_user.can_destroy?(p)
      add_error(:current_user, :unauthorized, 'user cannot perform this action')
    end

    p.destroy

    return nil
  end
end
