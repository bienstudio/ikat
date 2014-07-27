class Store
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Userstamps
  include Canable::Ables

  field :name,        type: String
  field :description, type: String
  field :domain,      type: String

  mount_uploader :logo, LogoUploader

  process_in_background :logo
  store_in_background   :logo

  field :logo_processing, type: Boolean
  field :logo_tmp,        type: String

  validates :name,   presence: true
  validates :domain, presence: true# unqiueness: true

  has_one :inventory, inverse_of: :owner

  after_create :create_inventory!

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
