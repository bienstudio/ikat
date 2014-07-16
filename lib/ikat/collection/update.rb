class CollectionUpdate < IkatMutation
  required do
    model :current_user, class: User
    hash  :collection do
      string  :id
      string  :name
      boolean :hidden
    end
  end

  def execute
    c = Collection.find(collection['id'])

    unless current_user.can_update?(c)
      add_error(:current_user, :unauthorized, 'user cannot perform this action')
    end

    c.update_attributes(collection)

    mongoid_errors!(c)

    c.save

    return c
  end
end
