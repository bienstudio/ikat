class ListItem
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Userstamps

  belongs_to :list
  belongs_to :product

  validates :list, presence: true
  validates :product, presence: true
  validates :created_by, presence: true

  after_create  :add_activity
  after_destroy :remove_activity

  # This is probably a terrible idea
  def destroy(actor = self.creator)
    self.updater = actor

    super
  end

  protected

  def add_activity
    Activity.create(
      action:  :add,
      subject: product,
      target:  list,
      actor:   creator
    )
  end

  def remove_activity
    Activity.create(
      action:  :remove,
      subject: product,
      target:  list,
      actor:   updater
    )
  end
end
