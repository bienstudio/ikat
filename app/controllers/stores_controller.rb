class StoresController < ApplicationController
  before_action :current_store

  def show
    @products = @store.inventory.list_items.order('created_at desc').map { |i| i.product }
  end

  def flux
    action = StoreFlux.run(
      current_user: current_user,
      store: {
        id: @store.id.to_s
      }
    )

    if action.success?
      redirect_to store_path(store_domain: @store.domain)
    else
      d { action.errors }
    end
  end

  def followers
    @users = Relationship.followers(@store).order('created_at desc').all
  end

  protected

  def current_store
    @store = Store.where(domain: params[:store_domain]).first
    @store
  end
end
