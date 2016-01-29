class UsersController < ApplicationController
  include PublicLevelHelper

  def show
    @user = User.find(params[:id])
    plevel = min_public_level_for(current_user, @user)
    bowels = @user.bowels.where("public_level >= ?", plevel)\
                  .order(created_at: :desc).limit(10)
    health_events = @user.health_events.where("public_level >= ?", plevel)\
                         .order(created_at: :desc).limit(10)
    @feed_items = bowels + health_events
    @feed_items = @feed_items.sort_by { |item| item.occurred_at }.reverse.slice(0, 10)
    @share_posts = @user.share_posts.where("public_level >= ?", plevel)\
                         .order(created_at: :desc).limit(10)
    @friend_users = @user.friend_users.limit(3).shuffle
  end

  def followings
    @title = "フォロー"
    @user = User.find(params[:id])
    @users = @user.following_users.page(params[:page])
    render 'person_list'
  end

  def followers
    @title = "フォロワー"
    @user = User.find(params[:id])
    @users = @user.follower_users.page(params[:page])
    render 'person_list'
  end
  
  def friends
    @title = "フレンド"
    @user = User.find(params[:id])
    @users = @user.friend_users.page(params[:page])
    render 'person_list'
  end
  
  def bowels
    @user = User.find(params[:id])
    plevel = min_public_level_for(current_user, @user)
    @bowels = @user.bowels.where("public_level >= ?", plevel)\
                    .order(created_at: :desc).page(params[:page])
    render 'item_list'
  end
  
  def health_events
    @user = User.find(params[:id])
    plevel = min_public_level_for(current_user, @user)
    @health_events = @user.health_events.where("public_level >= ?", plevel)\
                          .order(created_at: :desc).page(params[:page])
    render 'item_list'
  end
  
  def share_posts
    @user = User.find(params[:id])
    plevel = min_public_level_for(current_user, @user)
    @share_posts = @user.share_posts.where("public_level >= ?", plevel)\
                        .order(created_at: :desc).page(params[:page])
    render 'item_list'
  end
end
