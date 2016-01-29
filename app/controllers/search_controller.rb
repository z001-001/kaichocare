class SearchController < ApplicationController
  include PublicLevelHelper
  before_action :authenticate_user!

  def index
    if params[:q].present?
      @q = params[:q]
      @user = current_user
      bowels = Bowel.where("(user_id in (?) AND public_level >= ?) OR " +
                            "(user_id in (#{@user.friend_user_ids.join(',')}) AND public_level >= ?) OR " +
                            "(user_id in (#{@user.following_user_ids.join(',')}) AND public_level >= ?)",
                            @user.id, LEVEL_DEFAULT,
                            LEVEL_FRIEND_SUMMARY,
                            LEVEL_PUBLIC_SUMMARY)
      bowels = bowels.where("comment LIKE ?", "%#{@q}%")
      
      health_events = HealthEvent.where("(user_id in (?) AND public_level >= ?) OR " +
                            "(user_id in (#{@user.friend_user_ids.join(',')}) AND public_level >= ?) OR " +
                            "(user_id in (#{@user.following_user_ids.join(',')}) AND public_level >= ?)",
                            @user.id, LEVEL_DEFAULT,
                            LEVEL_FRIEND_SUMMARY,
                            LEVEL_PUBLIC_SUMMARY)
      health_events = health_events.where("(title LIKE ?) OR (comment LIKE ?)",
                            "%#{@q}%", "%#{@q}%")

      share_posts = SharePost.where("(user_id in (?) AND public_level >= ?) OR " +
                            "(user_id in (#{@user.friend_user_ids.join(',')}) AND public_level >= ?) OR " +
                            "(public_level >= ?)",
                            @user.id, LEVEL_DEFAULT,
                            LEVEL_FRIEND_SUMMARY,
                            LEVEL_PUBLIC_SUMMARY)
      share_posts = share_posts.where("(title LIKE ?) OR (comment LIKE ?)",
                            "%#{@q}%", "%#{@q}%")


      result_array = bowels + health_events + share_posts
      result_array = result_array.sort_by { |item| item.updated_at }.reverse
      @feed_items = Kaminari.paginate_array(result_array).page(params[:page])
    else
      redirect_to request.referrer || root_url
    end
  end

end
