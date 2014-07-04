class Activity
  include Mongoid::Document
  include Mongoid::Timestamps

  field :action, type: Symbol

  # The product being added
  belongs_to :subject, polymorphic: true

  # The target that the product is being added to
  belongs_to :target,  polymorphic: true

  # The actor the action is attributed to (i.e., User or Store)
  belongs_to :actor, polymorphic: true

  default_scope ->{ order('created_at desc') }

  # Get the feed for a user
  scope :feed, ->(u, actions) do
    self.in(actor: u.following, action: actions)
  end
end
