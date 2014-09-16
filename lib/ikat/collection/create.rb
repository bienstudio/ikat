class CollectionCreate < IkatMutation
  required do
    model :current_user, class: User
    hash  :collection do
      string :name
      string :description, empty: true
      boolean :hidden
    end
  end

  def execute
    c = Collection.new(collection)

    mongoid_errors!(c)

    current_user.collections << c

    c.owner_type = 'User'

    mongoid_errors!(current_user)

    current_user.save

    return c
  end
end
