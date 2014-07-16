class UserUnfollow < IkatMutation
  required do
    model :current_user, class: User
    hash  :user do
      string :id
    end
  end

  def execute
    u = User.find(user['id'])

    relationship = Relationship.where(
      follower: current_user,
      followee: u
    ).first

    unless current_user.can_destroy?(relationship)
      add_error(:current_user, :unauthorized, 'user cannot perform this action')
    end

    current_user.unfollow!(u)

    return nil
  end
end
