class List
  include Mongoid::Document
  include Mongoid::Timestamps

  # Do not use directly: use one of the subclasses.
  belongs_to :user

  has_and_belongs_to_many :products
end
