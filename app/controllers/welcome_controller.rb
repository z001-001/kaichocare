class WelcomeController < ApplicationController
  include PublicLevelHelper

  def index
    if user_signed_in?
      @user = current_user
      plevel = min_public_level_for(current_user, @user)
      bowels = Bowel.where("(user_id in (?) AND public_level >= ?) OR " +
                            "(user_id in (#{@user.friend_user_ids.join(',')}) AND public_level >= ?) OR " +
                            "(user_id in (#{@user.following_user_ids.join(',')}) AND public_level >= ?)",
                            @user.id, LEVEL_DEFAULT,
                            LEVEL_FRIEND_SUMMARY,
                            LEVEL_PUBLIC_SUMMARY)\
                    .order(created_at: :desc).limit(10)
      health_events = HealthEvent.where("(user_id in (?) AND public_level >= ?) OR " +
                            "(user_id in (#{@user.friend_user_ids.join(',')}) AND public_level >= ?) OR " +
                            "(user_id in (#{@user.following_user_ids.join(',')}) AND public_level >= ?)",
                            @user.id, LEVEL_DEFAULT,
                            LEVEL_FRIEND_SUMMARY,
                            LEVEL_PUBLIC_SUMMARY)\
                     .order(created_at: :desc).limit(10)
      @feed_items = bowels + health_events
      @feed_items = @feed_items.sort_by { |item| item.occurred_at }.reverse.slice(0, 10)

      @share_posts = SharePost.where("(user_id in (?) AND public_level >= ?) OR " +
                            "(user_id in (#{@user.friend_user_ids.join(',')}) AND public_level >= ?) OR " +
                            "(public_level >= ?)",
                            @user.id, LEVEL_DEFAULT,
                            LEVEL_FRIEND_SUMMARY,
                            LEVEL_PUBLIC_SUMMARY)\
                     .order(created_at: :desc).limit(10)

      @friend_users = @user.friend_users.limit(3).shuffle
    end
  end
end
