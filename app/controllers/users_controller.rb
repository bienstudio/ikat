class UsersController < ApplicationController
  before_action :current_user!

  # GET /:username
  def show
    @user = User.where(username: params[:username]).first
    @products = ListItem.where(list: @user.wants).order('created_at desc').limit(25).map { |i| i.product }
  end

  # POST /:username/flux
  def flux
    action = UserFlux.run(
      current_user: current_user,
      user: {
        id: @current_user.id.to_s
      }
    )

    if action.success?
      redirect_to profile_path(username: @current_user.username)
    else
      d { action.errors }
    end
  end

  # POST /:username/follow
  def follow
    follow = UserFollow.run(
      current_user: current_user,
      user: {
        id: @current_user.id.to_s
      }
    )

    if follow.success?
      redirect_to profile_path(username: @current_user.username)
    else
      d { follow.errors }
    end
  end

  # DELETE /:username/unfollow
  def unfollow
    unfollow = UserUnfollow.run(
      current_user: current_user,
      user: {
        id: @current_user.id.to_s
      }
    )

    if unfollow.success?
      redirect_to profile_path(username: @current_user.username)
    else
      d { unfollow.errors }
    end
  end

  def following
    @users = Relationship.following(@current_user).where(followee_type: 'User').order('created_at desc').all
    @stores = Relationship.following(@current_user).where(followee_type: 'Store').order('created_at desc').all
  end

  def followers
    @users = Relationship.followers(@current_user).order('created_at desc').all
  end

  protected

  def current_user!
    @current_user = User.where(username: params[:username]).first
    @current_user
  end
end
