class StoreCreate < IkatMutation
  required do
    model :current_user, class: User
    hash  :store do
      string :name
      string :description, empty: true
      string :domain
    end
  end

  def execute
    s = Store.new(store)
    s.creator = current_user
    s.updater = current_user

    mongoid_errors!(s)

    s.save

    return s
  end
end
