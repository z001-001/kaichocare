class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @share_posts = @user.share_posts.order(created_at: :desc)
  end
end
