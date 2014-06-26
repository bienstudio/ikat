class Store
  include Mongoid::Document

  field :name,        type: String
  field :description, type: String
  field :link,        type: String

  # TO-DO: Cover image

  has_many :products
end
