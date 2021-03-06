require 'securerandom'

class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Canable::Cans
  include Canable::Ables

  field :name,         type: String
  field :email,        type: String
  field :username,     type: String
  field :biography,    type: String
  field :location,     type: String
  field :website,      type: String
  field :admin,        type: Boolean, default: false
  field :access_token, type: String

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  field :encrypted_password, type: String, default: ""

  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  field :remember_created_at, type: Time

  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  mount_uploader :avatar, AvatarUploader

  process_in_background :avatar
  store_in_background   :avatar

  field :avatar_processing, type: Boolean
  field :avatar_tmp,        type: String

  validates :name, presence: true
  validates :username, presence: true, uniqueness: true

  has_one :wants,        inverse_of: :owner
  has_many :collections, inverse_of: :owner

  has_many :relationships

  before_create :create_access_token!

  after_create :create_lists!

  def viewable_by?(u)
    true
  end

  def creatable_by?(u)
    true
  end

  def updatable_by?(u)
    self == u || u.admin?
  end

  def destroyable_by?(u)
    updatable_by?(u)
  end

  def avatar_url(style = nil)
    if self.avatar_processing
      ActionController::Base.helpers.asset_path('avatar.png')
    else
      self.avatar.url(style)
    end
  end

  def feed(actions = [:add, :follow])
    Activity.feed(self, actions)
  end

  def following
    Relationship.following(self).collect(&:followee)
  end

  def followers
    Relationship.followers(self).collect(&:follower)
  end

  def follow!(obj)
    Relationship.create(
      follower: self,
      followee: obj
    )
  end

  def unfollow!(obj)
    relationship = self.relationships.where(followee: obj).first

    relationship ? relationship.destroy : false
  end

  def followed_by?(obj)
    self.relationships.where(follower: obj).first ? true : false
  end

  def follows?(obj)
    self.relationships.where(followee: obj).first ? true : false
  end

  private

  def create_access_token!
    self.access_token = SecureRandom.uuid
  end

  def create_lists!
    self.wants = Wants.create
  end
end
