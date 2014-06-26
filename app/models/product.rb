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
    storage:       :s3,
    url:           ':s3_alias_url',
    s3_credentials: File.join(Rails.root, 'config', 's3.yml'),
    s3_host_alias:  's3.amazonaws.com/ikat_development',
    styles: {
      original: ['1920x1680>', :jpg],
      large:    ['500x500>',   :jpg],
      medium:   ['250x250',    :jpg],
      small:    ['100x100#',   :jpg]
    },
    convert_options: { all: '-background white -flatten +matte' }

  validates_attachment_content_type :photo, content_type: ['image/jpg', 'image/jpeg']

  belongs_to :store
end
