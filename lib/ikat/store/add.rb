class StoreAdd < IkatMutation
  required do
    model :current_user, class: User
    hash  :store do
      string :url
    end
  end

  def execute
    domain = Store.domain_from_url(store['url'])

    if s = Store.where(domain: domain).first
      return s
    end

    s = Store.new(
      name:   domain,
      domain: domain
    )

    s.save

    return s
  end
end
