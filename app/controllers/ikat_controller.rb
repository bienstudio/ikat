class IkatController < ApplicationController
  include ActionController::Live

  # GET /
  def index
    @feed = current_user.feed.limit(20) if current_user
  end

  # GET /features
  def features
  end

  # GET /about
  def about
  end

  # GET /blog
  def blog
    redirect_to 'http://ikat.siteleaf.net'
  end

  # GET /support
  def support
  end

  # GET /explore
  def explore
    if params[:categories].nil?
      @category = nil
      @products = Product.order('created_at desc').limit(10)
      @breadcrumbs = []
      @children = Category.toplevel
    else
      params[:categories] = params[:categories].split('/')

      @category = Category.where(slug: params[:categories].last).first
      @breadcrumbs = @category.tree
      @children = @category.children

      @products = Product.in(category_ids: [@category.id]).order('updated_at desc').all
    end
  end

  # GET /bookmarklet
  def bookmarklet
    
  end
end
