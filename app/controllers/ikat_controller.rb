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
    @products = Product.order('created_at desc').limit(10)
  end
end
