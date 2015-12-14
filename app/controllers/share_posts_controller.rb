class SharePostsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    @share_post = current_user.share_posts.build(share_post_params)
    if @share_post.save
      flash[:success] = "Share post created!"
      redirect_to root_url
    else
      render 'welcome/index'
    end
  end

  def destroy
    @share_post = current_user.share_posts.find_by(id: params[:id])
    return redirect_to root_url if @share_post.nil?
    @share_post.destroy
    flash[:success] = "Share post deleted"
    redirect_to request.referrer || root_url
  end

  private
  def share_post_params
    params.require(:share_post).permit(:title, :comment, :public_level)
  end
end
