class IkatController < ApplicationController

  # GET /
  def index
  end

  # GET /features
  def features
  end

  # GET /about
  def about
  end

  # GET /blog
  def blog
    redirect_to 'http://getikat.tumblr.com'
  end

  # GET /support
  def support
  end
end
