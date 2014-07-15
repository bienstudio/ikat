class UsersController < ApplicationController

  # GET /:username
  def show
    @user = User.where(username: params[:username]).first
    @products = @user.wants.products.reverse # added at descending
  end
end
