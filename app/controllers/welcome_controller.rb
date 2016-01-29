class WelcomeController < ApplicationController
  include PublicLevelHelper

  def index
    if user_signed_in?
      @user = current_user

      sql_str = "(user_id = #{@user.id} AND public_level >= #{LEVEL_DEFAULT}) " +
        (@user.friend_user_ids.any? ?
          " OR (user_id in (#{@user.friend_user_ids.join(',')}) AND public_level >= #{LEVEL_FRIEND_SUMMARY}) " :
          "") +
        (@user.following_user_ids.any? ?
          " OR (user_id in (#{@user.following_user_ids.join(',')}) AND public_level >= #{LEVEL_PUBLIC_SUMMARY})" :
          "")

      bowels = Bowel.where(sql_str)
      bowels = bowels.order(created_at: :desc).limit(10)

      health_events = HealthEvent.where(sql_str)
      health_events = health_events.order(created_at: :desc).limit(10)

      @feed_items = bowels + health_events
      @feed_items = @feed_items.sort_by { |item| item.occurred_at }.reverse.slice(0, 10)

      @share_posts = SharePost.where(sql_str)
      @share_posts = @share_posts.order(created_at: :desc).limit(10)

      @friend_users = @user.friend_users.limit(3).shuffle
    end
  end
end
