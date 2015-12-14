class WelcomeController < ApplicationController
  def index
    @share_post = current_user.share_posts.build if user_signed_in?
  end
end
