class Inventory < List
  include Canable::Ables

  def viewable_by?(u)
    true
  end

  def creatable_by?(u)
    true
  end

  def updatable_by?(u)
    true
  end

  def destroyable_by?(u)
    false
  end

  protected

  def set_owner_type!
    self.owner_type = 'Store'
  end
end
