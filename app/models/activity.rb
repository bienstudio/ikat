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

  after_create :trigger_analytics!

  def associated_event
    case self.action
    when :click
      'Product Click'
    when :add
      "#{target.class.to_s} Add"
    when :remove
      "#{target.class.to_s} Remove"
    when :follow
      "#{target.class.to_s} Follow"
    when :unfollow
      "#{target.class.to_s} Unfollow"
    when :join
      'User Join'
    end
  end

  # protected

  def trigger_analytics!
    properties = {
      activity_id: self.id.to_s,
      actor_id: self.actor.id.to_s,
      actor_type: self.actor_type
    }

    if self.subject
      properties.merge!({
        subject_id: self.subject.id.to_s,
        subject_type: self.subject_type
      })
    end

    if self.target
      properties.merge!({
        target_id: self.target.id.to_s,
        target_type: self.target_type
      })
    end

    d { properties }

    Analytics.track(
      user_id: self.actor.id,
      event: self.associated_event,
      properties: properties
    )
  end
end
