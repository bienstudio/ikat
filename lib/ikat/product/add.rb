# This Mutation is called by the bookmarklet. It is passed information that it
#   collects from the page that it thinks fits into the fields needed. It then
#   checks to see whether there is a Product in the database that already
#   exists based on the URL. If there is an existing product, it'll check to
#   see if there is any new information that can be updated. If there is not
#   an existing product, it'll create a new one. If necessary, it'll also
#   create a new Store. After this is all completed, it'll add it to the
#   requested list.
class ProductAdd < Mutations::Command
  required do
    model :current_user, class: User
    hash  :product do
      string :url
      string :image_url
      string :title
      string :price
      string :list
    end
  end

  def execute
    # store = Store.first


    # If there is an existing product from this URL...
    if p = Product.where(link: product['url']).first
      # Check to see if there is information to be updated

    # If there is no existing product from this URL...
    else
      # Parse the price into the actual price and the currency

      # Build the Hash to be passed to ProductCreate

      # Run ProductCreate with the new Hash
      
    end

    # Finally, we can add it to the user's list
    list = List.find(product['list'])
    list.products << p
    list.save

    # And then return the Product
    return p
  end
end
