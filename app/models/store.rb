class Store
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  field :name,        type: String
  field :description, type: String
  field :link,        type: String

  has_mongoid_attached_file :logo,
    path:          'stores/:attachment/:id/:style.:extension',
    styles: {
      original: ['900x900>', :jpg],
      large:    ['500x500>',   :jpg],
      medium:   ['250x250',    :jpg],
      small:    ['100x100#',   :jpg]
    },
    convert_options: { all: '-background white -flatten +matte' }

  validates :name, presence: true
  validates :link, presence: true#, unqiueness: true

  validates_attachment :logo,
    content_type: { content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif'] }

  has_many :products
end
