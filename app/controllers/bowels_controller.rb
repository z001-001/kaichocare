class BowelsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_bowel, only: [:destroy, :edit, :update]

  def new
    @bowel = current_user.bowels.build
    # 分単位の時刻
    time_now = Time.zone.now
    @bowel.occurred_at = time_now - time_now.sec
    @bowel.public_level = current_user.bowel_public_level
  end

  def create
    @bowel = current_user.bowels.build(bowel_params)
    if @bowel.save
      flash[:success] = "記録しました"
      redirect_to current_user
    else
      render 'new'
    end
  end

  def show
    @bowel = Bowel.find(params[:id])
  end

  def edit
  end

  def update
    if @bowel.update(bowel_params)
      # 保存に成功した場合はshowにリダイレクト
      flash[:success] = "更新しました"
      redirect_to @bowel
    else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end

  def destroy
    #@bowel = current_user.bowels.find_by(id: params[:id])
    return redirect_to root_url if @bowel.nil?
    @bowel.destroy
    flash[:success] = "削除しました"
    redirect_to request.referrer || root_url
  end

  private
  def bowel_params
    params.require(:bowel).permit(:shape, :color, :amount, :comment, :feeling,
            :occurred_at, :public_level)
  end

  def set_bowel
    @bowel = current_user.bowels.find_by(id: params[:id])
  end
end
