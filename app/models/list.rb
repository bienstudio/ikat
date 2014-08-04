# Do not use directly: use one of the subclasses (Wants, Collections,
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

  def product_count
    self.list_item_ids.count
  end

  def add!(product, actor)
    ListItem.create(
      list:    self,
      product: product,
      creator: actor
    )
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
