class IkatController < ApplicationController

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
    redirect_to 'http://blog.getikat.com'
  end

  # GET /support
  def support
  end
end
