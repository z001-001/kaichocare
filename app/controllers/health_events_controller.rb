class HealthEventsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_health_event, only: [:destroy, :edit, :update]

  def new
    @health_event = current_user.health_events.build
    @health_event.occurred_at = Time.now
  end

  def create
    @health_event = current_user.health_events.build(health_event_params)
    if @health_event.save
      flash[:success] = "Health event created!"
      redirect_to current_user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @health_event.update(health_event_params)
      # 保存に成功した場合はトップページにリダイレクト
      flash[:success] = "Health event updated!"
      redirect_to current_user
    else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end

  def destroy
    #@health_event = current_user.health_events.find_by(id: params[:id])
    return redirect_to root_url if @health_event.nil?
    @health_event.destroy
    flash[:success] = "Health event deleted"
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
