class CollectionsController < ApplicationController
  before_action :current_user!, :current_collection!

  def index
    @collections = @current_user.collections
  end

  def show
    @current_collection = Collection.where(owner_id: @current_user.id, slug: params[:collection_slug]).first
  end

  def new
  end

  def create
    if params[:collection][:hidden]
      params[:collection][:hidden] = true
    else
      params[:collection][:hidden] = false
    end

    c = CollectionCreate.run(
      current_user: current_user,
      collection: params[:collection]
    )

    if c.success?
      redirect_to user_collection_path(username: c.result.owner.username, collection_slug: c.result.slug)
    else
      d { c.errors }
    end
  end

  def destroy
    c = CollectionDestroy.run(
      current_user: current_user,
      collection: {
        id: params[:id]
      }
    )

    if c.success?
      redirect_to user_collections_path(username: current_user.username)
    else
      d { c.errors }
    end
  end

  protected

  def current_user!
    @current_user = User.where(username: params[:username]).first
  end

  def current_collection!
    @current_collection = Collection.where(owner_id: @current_user.id, slug: params[:collection_slug]).first if @user
  end
end
