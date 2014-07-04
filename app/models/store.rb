class Store
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Userstamps
  include Mongoid::Paperclip
  include Canable::Ables

  field :name,        type: String
  field :description, type: String
  field :domain,      type: String

  has_mongoid_attached_file :logo,
    path:          'stores/:attachment/:id/:style.:extension',
    styles: {
      original: ['900x900>', :jpg],
      large:    ['500x500>',   :jpg],
      medium:   ['250x250',    :jpg],
      small:    ['100x100#',   :jpg]
    },
    convert_options: { all: '-background white -flatten +matte' }

  validates :name,   presence: true
  validates :domain, presence: true# unqiueness: true

  validates_attachment :logo,
    content_type: { content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif'] }

  has_many :products,
    after_add:     :add_activity,
    before_remove: :remove_activity

  scope :from_link, ->(link){ where(domain: url_to_domain(link)) }

  def viewable_by?(u)
    true
  end

  def creatable_by?(u)
    true
  end

  def updatable_by?(u)
    u.admin?
  end

  def destroyable_by?(u)
    updatable_by?(u)
  end

  def followers
    Relationship.followers(self).collect(&:follower)
  end

  class << self
    def url_to_domain(url)
      url = "http://#{url}" if URI.parse(url).scheme.nil?
      host = URI.parse(url).host.downcase
      host.start_with?('www.') ? host[4..-1] : host
    end
  end

  protected

  def add_activity(product)
    Activity.create(
      action:  :add,
      subject: product,
      target:  self,
      actor:   self
    )
  end

  def after_remove(product)
    Activity.create(
      action:  :remove,
      subject: product,
      target:  self,
      actor:   self
    )
  end
end
