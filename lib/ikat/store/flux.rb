class StoreFlux < IkatMutation
  required do
    model :current_user, class: User
    hash  :store do
      string :id
    end
  end

  def execute
    s = Store.find(store[:id])

    if current_user.follows?(s)
      current_user.unfollow!(s)
    else
      current_user.follow!(s)
    end
  end
end
