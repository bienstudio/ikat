# "Flux" the membership of a Product in a List. If it's already in the list,
#   remove it. If it isn't in the list, add it.
class ProductFlux < IkatMutation
  required do
    model :current_user, class: User
    model :product
    model :list
  end

  def execute
    if product.in_list?(list)
      i = list.remove!(product, current_user)

      if i == true
        i = nil
      end
    else
      i = list.add!(product, current_user)
    end

    # This shouldn't be necessary...
    return [product, i]
  end
end
