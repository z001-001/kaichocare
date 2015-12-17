class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @share_posts = @user.share_posts.order(created_at: :desc)
    @health_events = @user.health_events.order(created_at: :desc)
    @bowels = @user.bowels.order(created_at: :desc)
  end

  def followings
    @title = "Followings"
    @user = User.find(params[:id])
    @users = @user.following_users
    render 'followings_followers'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.follower_users
    render 'followings_followers'
  end
end
