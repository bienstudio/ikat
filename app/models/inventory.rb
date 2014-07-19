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
end