# Do not use directly: use one of the subclasses.
class List
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Userstamps

  belongs_to :user

  has_and_belongs_to_many :products,
    after_add:     :add_activity,
    before_remove: :remove_activity

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
    # if %w{Wants Owns}.include?(self._type)
    #   return false
    # end
    #
    # self.user == u

    true
  end

  protected

  def add_activity(product)
    Activity.create(
      action:  :add,
      subject: product,
      target:  self,
      actor:   self.user
    )
  end

  def remove_activity(product)
    Activity.create(
      action:  :remove,
      subject: product,
      target:  self,
      actor:   self.user
    )
  end
end
