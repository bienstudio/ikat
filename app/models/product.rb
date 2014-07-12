class Product
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Userstamps
  include Mongoid::Paperclip
  include Canable::Ables

  field :name,     type: String
  field :link,     type: String
  field :price,    type: Float
  field :currency, type: Symbol
  field :expired,  type: Boolean, default: false
  field :original_image, type: String

  has_mongoid_attached_file :photo,
    path:          'products/:attachment/:id/:style.:extension',
    styles: {
      original: ['1920x1680>', :jpg],
      large:    ['500x500>',   :jpg],
      medium:   ['250x250',    :jpg],
      small:    ['100x100#',   :jpg]
    },
    convert_options: { all: '-background white -flatten +matte' }

  validates :name,     presence: true
  validates :link,     presence: true
  validates :price,    presence: true
  validates :currency, presence: true
  validates :store,    presence: true
  validates :category, presence: true
  validates :original_image, presence: true

  validates_attachment :photo,
    presence: true,
    content_type: { content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif'] }

  belongs_to :store
  belongs_to :category

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

  class << self
    def currencies
      {
        usd: '$'
      }
    end
  end
end
