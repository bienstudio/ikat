class UserUpdate < IkatMutation
  required do
    model :current_user, class: User
    hash  :user do
      string :id
      string :email
      string :name
      string :username
      string :password, nils: true, empty: true
      string :password_confirmation, nils: true, empty: true
      file   :avatar, nils: true
    end
  end

  def execute
    u = User.find(user['id'])

    unless current_user.can_update?(u)
      add_error(:current_user, :unauthorized, 'user cannot perform this action')
    end

    u.update_attributes(user)
    u.save

    u
  end
end
