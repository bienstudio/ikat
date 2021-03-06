class Collection < List
  include Canable::Ables

  field :name,        type: String
  field :description, type: String
  field :slug,        type: String
  field :hidden,      type: Boolean, default: false

  validates :name, presence: true, uniqueness: true

  before_validation :create_slug!, :set_owner_type!

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

  protected

  def create_slug!
    if self.name
      str = self.name

      str = str.gsub(/[^a-zA-Z0-9 ][-]/, "")
      str = str.gsub(/[ ]+/, " ")
      str = str.gsub(/ /, "-")
      str = str.downcase

      self.slug = str
    end
  end

  def set_owner_type!
    self.owner_type = 'User'
  end
end
