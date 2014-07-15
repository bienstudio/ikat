class StoreDestroy < IkatMutation
  required do
    model :current_user, class: User
    hash  :store do
      string :id
    end
  end

  def execute
    s = Store.find(store['id'])

    unless current_user.can_destroy?(s)
      add_error(:current_user, :unauthorized, 'user cannot perform this action')
    end

    s.destroy

    mongoid_errors!(s)

    return nil
  end
end
