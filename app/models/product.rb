class Product
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Userstamps
  include Canable::Ables
  include Rails.application.routes.url_helpers

  field :name,     type: String
  field :link,     type: String
  field :price,    type: Float
  field :currency, type: Symbol
  field :expired,  type: Boolean, default: false
  field :original_image, type: String
  field :slug,     type: String
  field :store_id, type: ::BSON::ObjectId
  field :category_ids, type: Array

  mount_uploader :photo, PhotoUploader

  process_in_background :photo
  store_in_background   :photo

  field :photo_processing, type: Boolean
  field :photo_tmp,        type: String

  validates :name,     presence: true
  validates :link,     presence: true
  validates :price,    presence: true
  validates :currency, presence: true
  validates :category, presence: true
  validates :original_image, presence: true

  belongs_to :category

  before_validation :create_slug!
  before_save :populate_category_ids

  has_and_belongs_to_many :list_items

  def permalink
    "/products/#{self.id}"
  end

  def viewable_by?(u)
    true
  end

  def creatable_by?(u)
    true
  end

  def updatable_by?(u)
    true # Only on Product update?
  end

  def destroyable_by?(u)
    u.admin?
  end

  def photo_url(style = nil)
    if self.photo_processing
      ActionController::Base.helpers.asset_path('loading.png')
    else
      self.photo.url(style)
    end
  end

  def full_price
    str = "#{self.class.currencies[self.currency]}#{self.price.to_s.split('.').first}"

    decimals = self.price.to_s.split('.').last

    if decimals.size == 1
      str << ".#{decimals}0"
    else
      str << ".#{decimals}"
    end

    str
  end

  def permalink
    product_path(store_domain: self.store.domain, product_slug: self.slug)
  end

  def buy_permalink
    self.permalink + '/buy'
  end

  def categories
    self.category.tree
  end

  def category_ids
    self.category.tree.collect(&:id)
  end

  def store
    self.store_id ? Store.find(self.store_id) : nil
  end

  def in_wants?(u)
    ListItem.where(list: u.wants, product: self).first ? true : false
  end

  def in_collection?(c)
    ListItem.where(product: self).in(list: c).first ? true : false
  end

  def in_list?(l)
    ListItem.where(list: l, product: self).first ? true : false
  end

  def wanted_by
    ListItem.where(list_type: 'Wants', product: self).collect(&:creator)
  end

  class << self
    def currencies
      {
        usd: '$'
      }
    end
  end

  protected

  def create_slug!
    if self.name
      str = self.name

      str = str.gsub(/[^a-zA-Z0-9 ][-]/, "")
      str = str.gsub(/[ ]+/, " ")
      str = str.gsub(/ /, "-")
      str = str.downcase

      if store
        ids = ListItem.where(list_id: self.store.inventory.id).collect(&:id) # items in the store
        products = Product.in(list_item_ids: ids).where(slug: str)
        others = products.count

        if others > 1
          str = str + "-#{others}"
        end
      end

      self.slug = str
    end
  end

  def populate_category_ids
    self.category_ids = self.categories.collect(&:id)
  end
end
