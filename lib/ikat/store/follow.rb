class StoreFollow < IkatMutation
  required do
    model :current_user, class: User
    hash  :store do
      string :id
    end
  end

  def execute
    s = Store.find(store['id'])

    r = current_user.follow!(s)

    mongoid_errors!(r)

    r
  end
end
