class UserCreate < IkatMutation
  required do
    hash :user do
      string :email
      string :name
      string :username
      string :password
      string :password_confirmation
    end
  end

  def execute
    u = User.new(user)
    u.save

    mongoid_errors!(u)

    u
  end
end
