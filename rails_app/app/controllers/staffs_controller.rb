class StaffsController < ApplicationController
  before_action :admin_required
  before_action :set_staff, only: %i[edit update destroy]

  def index
    @q = Staff.ransack(params[:q])
    @staffs = @q ? @q.result : Staff.all
    @staffs = @staffs.order(name: :asc).page(params[:page])
  end

  def new
    @staff = Staff.new
  end

  def create
    @staff = @hospital.staffs.build(staff_params)
    if @staff.save
      redirect_to staffs_path, notice: t('notice.saved')
    else
      render :new
    end
  end

  def edit; end

  def update
    if @staff.update(staff_params)
      redirect_to staffs_path, notice: t('notice.updated')
    else
      render 'edit'
    end
  end

  def destroy
    if @staff.destroy
      redirect_to staffs_path, notice: t('notice.destroyed')
    end
  end

  private

  def set_staff
    @staff = Staff.find(params[:id])
  end

  def staff_params
    params.require(:staff).permit(
      :name,
      :password,
      :password_confirmation,
      :admin
      # :hospital_id
    )
  end
end
