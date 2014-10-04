class ExploreController < ApplicationController
  def show
    if params[:categories]
      # Category tree
      @breadcrumbs = Category.from_explore(params[:categories].split('/'))

      # The selected category
      @selected = @breadcrumbs.last

      # Children of the selected category
      @children = @selected.children

      # Products inside the selected category and its inverse tree (that
      #   category and all of its children's children)
      @products = Product.in(category_tree_ids: @children.collect(&:id))
    else
      @breadcrumbs = []
      @selected = nil
      @children = Category.toplevel

      @products = Product.order('created_at desc')
    end
  end
end
