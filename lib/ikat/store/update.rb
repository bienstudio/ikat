class StoreUpdate < IkatMutation
  required do
    model :current_user, class: User
    hash  :store do
      string :id
      string :name
      string :description, empty: true
      string :domain
    end
  end

  def execute
    s = Store.find(store['id'])

    unless current_user.can_update?(s)
      add_error(:current_user, :unauthorized, 'user cannot perform this action')
    end

    s.update_attributes(store)
    s.updater = current_user

    mongoid_errors!(s)

    s.save

    return s
  end
end
