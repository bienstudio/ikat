class Relationship
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :follower, class_name: 'User' # Stores can't follow people
  belongs_to :followee, polymorphic: true

  validates :follower, presence: true
  validates :followee, presence: true

  after_create  :follow_activity
  after_destroy :unfollow_activity

  scope :followers, ->(obj){ self.where(followee: obj) }
  scope :following, ->(obj){ self.where(follower: obj) }

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
