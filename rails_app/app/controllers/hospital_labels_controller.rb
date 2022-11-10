class HospitalLabelsController < ApplicationController
  before_action :set_hospital_label, only: %i[show edit update]
  before_action :master_required

  def index
    @q = HospitalLabel.ransack(params[:q])
    @hospital_labels = @q ? @q.result : HospitalLabel.all
    @hospital_labels = @hospital_labels.order(name: :asc) # .page(params[:page]).per(16)
  end

  def new
    @hospital_label = HospitalLabel.new
  end

  def create
    @hospital_label = HospitalLabel.create(hospital_label_params)
    if @hospital_label.save
      redirect_to hospital_labels_path, notice: t('notice.saved')
    else
      render :new
    end
  end

  def edit; end

  def update
    if @hospital_label.update(hospital_label_params)
      redirect_to hospital_labels_path, notice: t('notice.updated')
    else
      render :edit
    end
  end

  # def destroy
  #   @hospital_label.destroy
  #   respond_to do |format|
  #     format.html { redirect_to hospital_labels_path, notice: 'Label was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private

  def set_hospital_label
    @hospital_label = HospitalLabel.find(params[:id])
  end

  def hospital_label_params
    params.require(:hospital_label).permit(:name)
  end
end
