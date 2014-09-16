class ProductsController < ApplicationController
  before_action :current_store!, :current_product!

  def index
  end

  def new
  end

  def show
    @store = @current_store
    @product = Product.where(store_id: @current_store, slug: params[:product_slug]).first
  end

  def buy
    @product = Product.where(store_id: @current_store, slug: params[:product_slug]).first

    redirect_to @product.link
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

  def add
    params[:product][:category] = Category.find(params[:product][:category])

    p = ProductAdd.run(
      current_user: current_user,
      product: params[:product],
      list: List.find(params[:list])
    )

    if p.success?
      render json: p.result.to_json
    else
      d { p.errors }
    end
  end

  # POST /products/:product_id/flux
  #
  # Flux the membership the product in a list.
  def flux
    p = ProductFlux.run(
      current_user: current_user,
      product: @current_product,
      list: List.find(params[:list])
    )

    if p.success?
      # Is this a security vector?
      render json: p.result.first
    else
      render json: p.errors
    end
  end

  protected

  def current_store!
    @current_store = Store.where(domain: params[:store_domain]).first
    @current_store
  end

  def current_product!
    if params[:product_slug]
      @current_product = Product.where(store_id: @current_store, slug: params[:product_slug]).first
    end

    if params[:product_id]
      @current_product = Product.find(params[:product_id])
    end

    @current_product
  end
end
