class StoresController < ApplicationController
  before_filter :current_store

  def show
    @products = @current_store.inventory.list_items.order('created_at desc').collect(&:product)
  end

  protected

  def current_store
    @current_store = Store.where(domain: params[:store_domain]).first
    @current_store
  end
end
