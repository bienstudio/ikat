class ActivityCreate < IkatMutation
  required do
    model :current_user, class: User
    hash  :activity do
      model  :action,  class: Symbol
      model  :subject, class: Product, nils: true
      model  :target,  class: List, nils: true
      model  :actor,   class: User
    end
  end

  def execute
    a = Activity.new(activity)

    mongoid_errors!(a)

    a.save

    return a
  end
end
