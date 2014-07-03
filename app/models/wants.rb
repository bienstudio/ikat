class Wants < List
  include Canable::Ables

  def viewable_by?(u)
    true
  end

  def creatable_by?(u)
    true
  end

  def updatable_by?(u)
    self.user == u
  end

  def destroyable_by?(u)
    false
  end

end
