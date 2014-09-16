class WantsController < ApplicationController
  before_action :current_user!

  def show
    @products = ListItem.where(list: @current_user.wants).order('created_at desc').limit(25).map { |i| i.product }
  end

  protected

  def find_user!
    @current_user = User.where(username: params[:username]).first
  end
end
