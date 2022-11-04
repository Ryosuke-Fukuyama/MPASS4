class MastersController < ApplicationController
  before_action :master_required

  def index
    @q = Master.ransack(params[:q])
    @masters = @q ? @q.result : Master.all
    @masters = @masters.order(created_at: :asc).page(params[:page]).per(8)
  end

  def show; end

  def destroy
    @master = Master.find(params[:id])
    @master.destroy
    redirect_to masters_path, notice: t('notice.destroyed')
  end
end
