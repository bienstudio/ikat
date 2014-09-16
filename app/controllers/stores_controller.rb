class StoresController < ApplicationController
  before_action :current_store!

  def show
    @products = @current_store.inventory.list_items.order('created_at desc').map { |i| i.product }
  end

  def flux
    action = StoreFlux.run(
      current_user: current_user,
      store: {
        id: @current_store.id.to_s
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

  def current_store!
    @current_store = Store.where(domain: params[:store_domain]).first
    @current_store
  end
end
