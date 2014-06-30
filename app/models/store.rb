class Store
  include Mongoid::Document

  field :name,        type: String
  field :description, type: String
  field :link,        type: String

  has_mongoid_attached_file :logo,
    path:          'stores/:attachment/:id/:style.:extension',
    storage:       :s3,
    url:           ':s3_alias_url',
    s3_credentials: File.join(Rails.root, 'config', 's3.yml'),
    s3_host_alias:  's3.amazonaws.com/ikat_development',
    styles: {
      original: ['900x900>', :jpg],
      large:    ['500x500>',   :jpg],
      medium:   ['250x250',    :jpg],
      small:    ['100x100#',   :jpg]
    },
    convert_options: { all: '-background white -flatten +matte' }

  has_many :products
end
