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
  field :store_id, type: ::BSON::ObjectId

  has_mongoid_attached_file :photo,
    path: 'products/:attachment/:id/:style.:extension',
    styles: {
      original: ['2000x2000>', :jpg],
      large:    ['1000x1000>', :jpg],
      medium:   ['500x500>',   :jpg],
      small:    ['250x250>',   :jpg]
    },
    convert_options: { all: '-background white -flatten +matte -trim' }

  # process_in_background :photo

  validates :name,     presence: true
  validates :link,     presence: true
  validates :price,    presence: true
  validates :currency, presence: true
  validates :category, presence: true
  validates :original_image, presence: true

  validates_attachment :photo,
    presence: true,
    content_type: { content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif'] }

  belongs_to :category

  before_validation :create_slug!

  has_and_belongs_to_many :list_items

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

  def store
    self.store_id ? Store.find(self.store_id) : nil
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

      if store
        ids = ListItem.where(list_id: self.store.inventory.id).collect(&:id) # items in the store
        products = Product.in(list_item_ids: ids).where(slug: str)
        others = products.count

        if others > 1
          str = str + "-#{others}"
        end
      end

      self.slug = str
    end
  end
end
