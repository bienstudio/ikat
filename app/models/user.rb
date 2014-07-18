class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
  include Canable::Cans
  include Canable::Ables

  field :name,      type: String
  field :email,     type: String
  field :username,  type: String
  field :biography, type: String
  field :location,  type: String
  field :website,   type: String
  field :admin,     type: Boolean, default: false

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

  has_mongoid_attached_file :avatar,
    path:          'users/:attachment/:id/:style.:extension',
    styles: {
      original: ['900x900#', :jpg],
      large:    ['500x500#', :jpg],
      medium:   ['250x250#', :jpg],
      small:    ['100x100#', :jpg]
    },
    convert_options: { all: '-background white -flatten +matte' },
    default_url: '/assets/avatar.png'

  validates_attachment :avatar,
    content_type: { content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif'] }

  validates :name, presence: true
  validates :username, presence: true, uniqueness: true

  has_one :wants,        inverse_of: :owner
  has_one :owns,         inverse_of: :owner
  has_many :collections, inverse_of: :owner

  has_many :relationships

  after_save :create_lists!

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

  private

  def create_lists!
    self.wants = Wants.create
    self.owns = Owns.create
  end
end
