class CollectionsController < ApplicationController
  before_filter :find_user!, :find_collection!

  def index
    @collections = @user.collections
  end

  def show
  end

  protected

  def find_user!
    @user = User.where(username: params[:username]).first
  end

  def find_collection!
    @collection = Collection.where(owner_id: @user.id, slug: params[:collection_slug]).first
  end
end
