class IkatController < ApplicationController

  # GET /
  def index
    if current_user
      @feed = current_user.feed.limit(20)
    end
  end

  # GET /features
  def features
  end

  # GET /about
  def about
  end

  # GET /blog
  def blog
    redirect_to 'https://medium.com/@getikat'
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
      @breadcrumbs = @category.all_parents
      @children = @category.children

      @products = Product.in(category_ids: [@category.id]).order('updated_at desc').all
    end
  end

  # GET /bookmarklet
  def bookmarklet
    fetch = BookmarkletFetchImages.run(
      url: params[:url]
    )

    @images = fetch.result

    render layout: false
  end
end
