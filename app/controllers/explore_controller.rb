class ExploreController < ApplicationController
  def show
    if params[:categories]
      # Category tree
      @category = Category.from_explore(params[:categories].split('/'))

      @breadcrumbs = @category.ancestors_and_self

      # The selected category
      @selected = @category

      # Children of the selected category
      @children = @selected.children

      # Products inside the selected category and its inverse tree (that
      #   category and all of its children's children)
      @products = Product.in(category_id: @category.descendants_and_self.collect(&:id))
    else
      @breadcrumbs = []
      @selected = nil
      @children = Category.roots

      @products = Product.order('created_at desc')
    end
  end
end
