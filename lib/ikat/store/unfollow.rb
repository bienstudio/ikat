class StoreUnfollow < IkatMutation
  required do
    model :current_user, class: User
    hash  :store do
      string :id
    end
  end

  def execute
    s = Store.find(store['id'])

    relationship = Relationship.where(
      follower: current_user,
      followee: s
    ).first

    unless current_user.can_destroy?(relationship)
      add_error(:current_user, :unauthorized, 'user cannot perform this action')
    end

    current_user.unfollow!(s)

    return nil
  end
end
