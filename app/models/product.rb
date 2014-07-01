class Product
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  field :name,     type: String
  field :link,     type: String
  field :price,    type: Float
  field :currency, type: Symbol

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

  validates_attachment :photo,
    presence: true,
    content_type: { content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif'] }

  belongs_to :store

  has_and_belongs_to_many :lists
end
