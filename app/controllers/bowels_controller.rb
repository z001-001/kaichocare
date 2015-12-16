class BowelsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_bowel, only: [:destroy, :edit, :update]

  def new
    @bowel = current_user.bowels.build
    @bowel.occurred_at = Time.now
  end

  def create
    @bowel = current_user.bowels.build(bowel_params)
    if @bowel.save
      flash[:success] = "bowel created!"
      redirect_to current_user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @bowel.update(bowel_params)
      # 保存に成功した場合はトップページにリダイレクト
      flash[:success] = "bowel updated!"
      redirect_to current_user
    else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end

  def destroy
    #@bowel = current_user.bowels.find_by(id: params[:id])
    return redirect_to root_url if @bowel.nil?
    @bowel.destroy
    flash[:success] = "Bowel deleted"
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
