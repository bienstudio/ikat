class Category
  include Mongoid::Document
  include Rails.application.routes.url_helpers

  field :name,  type: String
  field :color, type: String
  field :slug,  type: String

  validates :name, presence: true

  before_validation :create_slug!

  belongs_to :parent,   class_name: 'Category'
  has_many   :children, class_name: 'Category'

  has_many :products

  scope :toplevel, ->{ where(parent_id: nil) }

  def tree
    unless self.parent_id.nil?
      p = [self, self.parent]

      while p.last.parent
        p << p.last.parent
      end

      p.reverse
    else
      [self]
    end
  end

  def permalink
    if !self.tree.nil?
      arr = self.tree
    else
      arr = [self]
    end

    str = arr.collect(&:slug).join('/')

    "/explore/#{str}"
  end

  class << self
    def lowest
      cats = []

      self.all.each do |c|
        cats << c
      end

      cats
    end

    def as_options
      options = []

      lowest.each do |c|
        str = " > #{c.name}"

        current = c
        while current.has_parent?
          str.insert(0, " > #{current.parent.name}")

          current = current.parent
        end

        str = str[3..-1]

        options << [c.id.to_s, str]

        options.sort_by { |a| a.last }
      end

      options
    end

    def from_explore(arr)
      cats = []

      arr.each do |c|

        # This is the parent
        if cats.empty?
          cats << Category.where(slug: c).first

        # This is a child
        else
          parent = cats.last
          cats << parent.children.where(slug: c).first
        end
      end

      cats
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
end
