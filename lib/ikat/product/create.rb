# This Mutation is responsible for actually carrying out the creation of the
#   Product. It will create a new Store if there is not one found at the domain
#   that is in the Product's link.

# To-do: Create a new store if need be
class ProductCreate < Mutations::Command
  required do
    model :current_user, class: User
    hash  :product do
      string :name
      string :link
      float  :price
      model  :currency, class: Symbol
      string :photo
    end
  end

  def execute
    p = Product.new(product)
    p.save

    p
  end
end
