class Relationship
  include Mongoid::Document
  include Mongoid::Timestamps

  # The User doing the following.
  belongs_to :follower, class_name: 'User' # Stores can't follow people

  # The User or Store being followed.
  belongs_to :followee, polymorphic: true

  validates :follower, presence: true
  validates :followee, presence: true

  after_create  :follow_activity
  after_destroy :unfollow_activity

  # Followers of the Object.
  scope :followers, ->(obj){ where(followee: obj) }

  # Objects the Object is following.
  scope :following, ->(obj){ where(follower: obj).ne(followee_id: obj.id) }

  def viewable_by?(u)
    true
  end

  def creatable_by?(u)
    true
  end

  def updatable_by?(u)
    false # Can't update
  end

  def destroyable_by?(u)
    self.follower == u
  end

  protected

  def follow_activity
    Activity.create(
      action:  :follow,
      subject: followee,
      target:  followee,
      actor:   follower
    )
  end

  def unfollow_activity
    Activity.create(
      action:  :unfollow,
      subject: followee,
      target:  followee,
      actor:   follower
    )
  end
end
