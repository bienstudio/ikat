class ProductsController < ApplicationController
  before_filter :current_store

  def index
  end

  def new
  end

  def show
    @store = @current_store
    @product = Product.where(store_id: @store, slug: params[:product_slug]).first
  end

  def create
    params[:product][:category] = Category.where(name: 'Tops').first

    p = ProductAdd.run(
      current_user: current_user,
      product: params[:product],
      list: current_user.wants
    )

    if p.success?
      redirect_to p.result.permalink
    else
      d { p.errors }
    end
  end

  protected

  def current_store
    @current_store = Store.where(domain: params[:store_domain]).first
    @current_store
  end
end
