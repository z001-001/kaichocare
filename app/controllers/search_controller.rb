class SearchController < ApplicationController
  include PublicLevelHelper
  before_action :authenticate_user!

  def index
    if params[:q].present?
      @q = params[:q]
      @user = current_user

      sql_str = "(user_id = #{@user.id} AND public_level >= #{LEVEL_DEFAULT}) " +
        (@user.friend_user_ids.any? ?
          " OR (user_id in (#{@user.friend_user_ids.join(',')}) AND public_level >= #{LEVEL_FRIEND_SUMMARY}) " :
          "") +
        (@user.following_user_ids.any? ?
          " OR (user_id in (#{@user.following_user_ids.join(',')}) AND public_level >= #{LEVEL_PUBLIC_SUMMARY})" :
          "")

      bowels = Bowel.where(sql_str)
      bowels = bowels.where("comment LIKE ?", "%#{@q}%").limit(50)

      health_events = HealthEvent.where(sql_str)
      health_events = health_events.where("(title LIKE ?) OR (comment LIKE ?)",
                            "%#{@q}%", "%#{@q}%").limit(50)

      share_posts = SharePost.where(sql_str)
      share_posts = share_posts.where("(title LIKE ?) OR (comment LIKE ?)",
                            "%#{@q}%", "%#{@q}%").limit(50)


      result_array = bowels + health_events + share_posts
      result_array = result_array.sort_by { |item| item.updated_at }.reverse
      @feed_items = Kaminari.paginate_array(result_array).page(params[:page])
    else
      redirect_to request.referrer || root_url
    end
  end

end
