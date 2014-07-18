class ProductRemove < IkatMutation
  required do
    model :current_user, class: User
    model :product
    model :list
  end

  def execute
    unless current_user.can_update?(list)
      add_error(:current_user, :unauthorized, 'user cannot perform this action')
    end

    list.remove!(product, current_user)

    mongoid_errors!(list)

    list.save

    return list
  end
end
