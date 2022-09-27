class HospitalsController < ApplicationController
  before_action :set_hospital_parms, only: %i[show]
  before_action :set_hospital_labels, only: %i[index search new edit create update]
  before_action :admin_required, only: %i[edit update destroy]
  before_action :master_required, only: %i[new create]

  def index
    @q = Hospital.ransack(params[:q])
    @hospitals =  @q ? @q.result : Hospital.all
    @hospitals = @hospitals.includes(:hospital_labels).order(name: :asc).page(params[:page]).per(8)
  end

  def search
    index
    render :index
  end

  # def maps
  #   gon.hosupitals = Hospital.all
  # end

  def new
    @hospital = Hospital.new
    @hospital.staffs.build
  end

  def create
    @hospital = Hospital.new(hospital_params)
    if @hospital.save
      redirect_to hospitals_path, notice: t('notice.saved')
    else
      render :new
    end
  end

  def show
    @favorite_hospital = current_patient.favorite_hospitals.find_by(hospital_id: @hospital.id) if patient_signed_in?
  end

  def edit; end

  def update
    @hospital.hospital_labelings.delete_all unless params[:hospital][:hospital_label_ids]
    if @hospital.update(hospital_params)
      redirect_to hospital_path(@hospital), notice: t('notice.updated')
    else
      render :edit
    end
  end

  def destroy
    @hospital.destroy
    redirect_to hospitals_path, notice: t('notice.destroyed')
  end

  private
    def hospital_params
      params.require(:hospital).permit(
        :id,
        :name,
        :email,
        :tel,
        :address,
        :access,
        :introduction,
        :image,
        hospital_label_ids: [],
        staffs_attributes: [
          :id,
          :name,
          :password,
          :password_confirmation,
          :admin
        ]
      )
    end

    def set_hospital_parms
      @hospital = Hospital.find_by(id: params[:id])
    end

    def set_hospital_labels
      @hospital_labels = HospitalLabel.all
    end
end
