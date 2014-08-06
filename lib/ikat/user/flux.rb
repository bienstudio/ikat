class UserFlux < IkatMutation
  required do
    model :current_user, class: User
    hash  :user do
      string :id
    end
  end

  def execute
    u = User.find(user[:id])

    if current_user.follows?(u)
      current_user.unfollow!(u)
    else
      current_user.follow!(u)
    end
  end
end
