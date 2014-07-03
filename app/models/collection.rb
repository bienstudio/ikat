class Collection < List
  field :name, type: String

  validates :name, presence: true
end
