class Product
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Userstamps
  include Mongoid::Paperclip
  include Canable::Ables
  include Rails.application.routes.url_helpers

  field :name,     type: String
  field :link,     type: String
  field :price,    type: Float
  field :currency, type: Symbol
  field :expired,  type: Boolean, default: false
  field :original_image, type: String
  field :slug,     type: String

  has_mongoid_attached_file :photo,
    path:          'products/:attachment/:id/:style.:extension',
    styles: {
      original: ['1000x1000#', :jpg],
      large:    ['500x500#',   :jpg],
      medium:   ['250x250#',    :jpg],
      small:    ['100x100#',   :jpg]
    },
    convert_options: { all: '-background white -flatten +matte' }

  # process_in_background :photo

  validates :name,     presence: true
  validates :link,     presence: true
  validates :price,    presence: true
  validates :currency, presence: true
  validates :store,    presence: true
  validates :category, presence: true
  validates :original_image, presence: true
  validates :slug,     presence: true

  validates_attachment :photo,
    presence: true,
    content_type: { content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif'] }

  belongs_to :store
  belongs_to :category

  before_validation :create_slug!

  has_and_belongs_to_many :lists

  def permalink
    "/products/#{self.id}"
  end

  def viewable_by?(u)
    true
  end

  def creatable_by?(u)
    true
  end

  def updatable_by?(u)
    true # Only on Product update?
  end

  def destroyable_by?(u)
    u.admin?
  end

  def full_price
    "#{self.class.currencies[self.currency]}#{(self.price % 1 != 0 ? self.price : self.price.to_i )}"
  end

  def permalink
    product_path(store_domain: self.store.domain, product_slug: self.slug)
  end

  class << self
    def currencies
      {
        usd: '$'
      }
    end
  end

  protected

  def create_slug!
    if self.name
      str = self.name

      str = str.gsub(/[^a-zA-Z0-9 ]/,"")
      str = str.gsub(/[ ]+/," ")
      str = str.gsub(/ /,"-")
      str = str.downcase

      others = self.class.where(store_id: self.store_id, slug: str).count

      if others > 1
        str = str + "-#{others}"
      end

      self.slug = str
    end
  end
end
