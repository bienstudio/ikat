# Do not use directly: use one of the subclasses (Wants, Owns, Collections,
#   or Inventory).
class List
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Userstamps

  belongs_to :owner, polymorphic: true

  has_and_belongs_to_many :list_items

  def products
    ListItem.where(list: self).collect(&:product)
  end

  def add!(product, actor)
    i = ListItem.create(
      list:    self,
      product: product,
      creator: actor
    )

    self.list_item_ids << i.id
    self.save

    product.list_item_ids << i.id
    product.save

    i
  end

  def remove!(product, actor)
    item = ListItem.where(
      list:    self,
      product: product
    ).first

    item ? item.destroy(actor) : false
  end

  def viewable_by?(u)
    true
  end

  def creatable_by?(u)
    true
  end

  def updatable_by?(u)
    self.owner == u
  end

  def destroyable_by?(u)
    true
  end
end
