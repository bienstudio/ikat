class Category
  include Mongoid::Document

  field :name,  type: String
  field :color, type: String

  validates :name, presence: true

  belongs_to :parent,   class_name: 'Category'
  has_many   :children, class_name: 'Category'

  has_many :products

  scope :toplevel, ->{ where(parent_id: nil) }
end
