class ListItem
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Userstamps

  belongs_to :list
  belongs_to :product

  validates :list, presence: true
  validates :product, presence: true
  validates :created_by, presence: true

  before_create  :populate_list_item_ids
  before_destroy :depopulate_list_item_ids

  after_create   :add_activity
  after_destroy  :remove_activity

  # This is probably a terrible idea
  def destroy(actor = self.creator)
    self.updater = actor

    super
  end

  protected

  def populate_list_item_ids
    self.list.list_item_ids << self.id
    self.list.save

    self.product.list_item_ids << self.id
    self.product.save
  end

  def depopulate_list_item_ids
    self.list.list_item_ids.delete(self.id)
    self.list.save

    self.product.list_item_ids.delete(self.id)
    self.product.save
  end

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
