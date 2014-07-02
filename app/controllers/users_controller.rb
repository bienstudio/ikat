class UsersController < ApplicationController

  # GET /:username
  def show
    @user = User.where(username: params[:username]).first

    d { @user }
  end
end
