class Collection < List
  include Canable::Ables

  field :name,   type: String
  field :hidden, type: Boolean, default: false

  validates :name, presence: true

  def viewable_by?(u)
    if self.hidden?
      u == self.user
    else
      true
    end
  end

  def creatable_by?(u)
    true
  end

  def updatable_by?(u)
    self.user == u
  end

  def destroyable_by?(u)
    self.updatable_by?(u)
  end
end
