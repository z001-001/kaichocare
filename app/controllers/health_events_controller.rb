class HealthEventsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_health_event, only: [:destroy, :edit, :update]

  def new
    @health_event = current_user.health_events.build
    # 分単位の時刻
    time_now = Time.zone.now
    @health_event.occurred_at = time_now - time_now.sec
    @health_event.public_level = current_user.health_event_public_level
  end

  def create
    @health_event = current_user.health_events.build(health_event_params)
    if @health_event.save
      flash[:success] = "記録しました"
      redirect_to current_user
    else
      render 'new'
    end
  end

  def show
    @health_event = HealthEvent.find(params[:id])
  end

  def edit
  end

  def update
    if @health_event.update(health_event_params)
      # 保存に成功した場合はshowジにリダイレクト
      flash[:success] = "更新しました"
      redirect_to @health_event
    else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end

  def destroy
    #@health_event = current_user.health_events.find_by(id: params[:id])
    return redirect_to root_url if @health_event.nil?
    @health_event.destroy
    flash[:success] = "削除しました"
    redirect_to request.referrer || root_url
  end

  private
  def health_event_params
    params.require(:health_event).permit(:title, :comment, :feeling,
            :occurred_at, :ended_at, :public_level)
  end

  def set_health_event
    @health_event = current_user.health_events.find_by(id: params[:id])
  end
end
