class SharePostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_share_post, only: [:destroy, :edit, :update]

  def new
    @share_post = current_user.share_posts.build
    @share_post.public_level = current_user.share_post_public_level
  end

  def create
    @share_post = current_user.share_posts.build(share_post_params)
    if @share_post.save
      flash[:success] = "投稿しました"
      redirect_to current_user
    else
      render 'new'
    end
  end
  
  def show
    @share_post = SharePost.find(params[:id])
  end

  def edit
  end

  def update
    if @share_post.update(share_post_params)
      # 保存に成功した場合はshowにリダイレクト
      flash[:success] = "更新しました"
      redirect_to @share_post
    else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end

  def destroy
    #@share_post = current_user.share_posts.find_by(id: params[:id])
    return redirect_to root_url if @share_post.nil?
    @share_post.destroy
    flash[:success] = "削除しました"
    redirect_to current_user || root_url
  end

  private
  def share_post_params
    params.require(:share_post).permit(:title, :comment, :public_level)
  end

  def set_share_post
    @share_post = current_user.share_posts.find_by(id: params[:id])
  end
end
