class Collection < List
  include Canable::Ables

  field :name,   type: String
  field :hidden, type: Boolean, default: false

  validates :name, presence: true

  def viewable_by?(u)
    self.hidden? ? u == self.owner : true
  end

  def creatable_by?(u)
    true
  end

  def updatable_by?(u)
    self.owner == u
  end

  def destroyable_by?(u)
    self.updatable_by?(u)
  end
end
