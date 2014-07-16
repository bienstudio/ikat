class UserFollow < IkatMutation
  required do
    model :current_user, class: User
    hash  :user do
      string :id
    end
  end

  def execute
    u = User.find(user['id'])

    r = current_user.follow!(u)

    mongoid_errors!(r)

    return r
  end
end
