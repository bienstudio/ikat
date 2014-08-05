class WantsController < ApplicationController
  before_action :find_user!

  def show
    @products = ListItem.where(list: @user.wants).order('created_at desc').limit(25).map { |i| i.product }
  end

  protected

  def find_user!
    @user = User.where(username: params[:username]).first
  end
end
