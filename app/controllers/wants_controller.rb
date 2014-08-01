class WantsController < ApplicationController
  before_filter :find_user!

  def show
    @products = ListItem.where(list: @user.wants).order('created_at desc').limit(25).collect(&:product)
  end
  
  protected

  def find_user!
    @user = User.where(username: params[:username]).first
  end
end
