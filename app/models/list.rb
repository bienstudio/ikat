# Do not use directly: use one of the subclasses.
class List
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user

  has_and_belongs_to_many :products,
    after_add:     :add_activity,
    before_remove: :remove_activity

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
