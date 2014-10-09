class Category
  include Mongoid::Document
  include Mongoid::Ancestry
  include Rails.application.routes.url_helpers

  field :name,  type: String
  field :color, type: String
  field :slug,  type: String

  validates :name, presence: true

  before_validation :create_slug!, :add_color!

  has_many :products

  has_ancestry

  def ancestors_and_self
    arr = self.ancestors.to_a

    arr.push(self)

    arr
  end

  def descendants_and_self
    arr = self.descendants.to_a

    arr.push(self)

    arr
  end

  def permalink
    categories = self.ancestors_and_self.collect(&:slug).join('/')

    "/explore/#{categories}"
  end

  def self.as_options
    options = []

    self.roots.each do |root|
      root.descendants_and_self.each do |leaf|
        str = ''

        leaf.ancestors_and_self.each do |ancestor|
          str << "#{ancestor.name} > "
        end

        idx = leaf.id.to_s
        str = str[0..-4]

        options << [idx, str]
      end
    end

    options
  end

  def self.from_explore(arr)
    current_str = arr.first
    current_obj = Category.roots.where(slug: current_str).first
    current_idx = 0

    # Try and accurately get to the last category, since there are many
    #   categories named similarly.
    while current_str != arr.last
      current_idx = current_idx + 1
      current_str = arr[current_idx]
      current_obj = current_obj.children.where(slug: current_str).first
    end

    current_obj
  end

  def self.as_html(urls = true)
    @html = '<ul class="category-picker">'

    self.arrange.each(&method(:hash_to_html))

    @html << '</ul>'

    @html
  end

  def self.named_arrange
    Ikat::Utilities.transform_hash(Category.arrange, deep: true) do |hash, key, value|
      hash[key.id.to_s] = { name: key.name, children: value }
    end
  end

  protected

  def create_slug!
    if self.name
      str = self.name

      str = str.gsub(/[^a-zA-Z0-9 ]/,"")
      str = str.gsub(/[ ]+/," ")
      str = str.gsub(/ /,"-")
      str = str.downcase

      self.slug = str
    end
  end

  def add_color!
    unless self.color
      if self.parent && self.parent.color?
        self.color = self.parent.color
      end
    end
  end

  def self.hash_to_html(key, value)
    if value.blank?
      @html << "<li><a href='#' style='color: #{key.color}'>#{key.name}</a></li>"
    else
      @html << "<li><a href='#' style='color: #{key.color}'>#{key.name}</a>"
      @html << "<ul>"

      value.each(&method(:hash_to_html))

      @html << "</ul></li>"
    end
  end
end
