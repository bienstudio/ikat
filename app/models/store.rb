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

  has_one :inventory, inverse_of: :owner

  after_save :create_inventory!

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
    def domain_from_url(url)
      url = "http://#{url}" if URI.parse(url).scheme.nil?
      host = URI.parse(url).host.downcase
      host.start_with?('www.') ? host[4..-1] : host
    end
  end

  protected

  def create_inventory!
    self.inventory = Inventory.create
  end
end
