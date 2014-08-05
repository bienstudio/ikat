class UsersController < ApplicationController
  before_action :find_user

  # GET /:username
  def show
    @user = User.where(username: params[:username]).first
    @products = ListItem.where(list: @user.wants).order('created_at desc').limit(25).map { |i| i.product }
  end

  # POST /:username/follow
  def follow
    follow = UserFollow.run(
      current_user: current_user,
      user: {
        id: @user.id.to_s
      }
    )

    if follow.success?
      redirect_to profile_path(username: @user.username)
    else
      d { follow.errors }
    end
  end

  # DELETE /:username/unfollow
  def unfollow
    unfollow = UserUnfollow.run(
      current_user: current_user,
      user: {
        id: @user.id.to_s
      }
    )

    if unfollow.success?
      redirect_to profile_path(username: @user.usernmame)
    else
      d { unfollow.errors }
    end
  end

  protected

  def find_user
    @user = User.where(username: params[:username]).first
    @user
  end
end
