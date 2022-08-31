class HospitalsController < ApplicationController
  before_action :set_hospital_parms, only: %i[show edit update destroy]
  before_action :set_hospital_labels, only: %i[index search new edit create update]
  # before_action :admin_required, only: %i[edit update]
  # before_action :master_required, only: %i[new create]

  def index
    @q = ransack_params
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
    @form = HospitalForm.new
  end

  def create
    @form = HospitalForm.new(hospital_params)
    binding.irb
    if @form.save
    # if @staff.present?
    #   if @hospital.save
    #     id = @hospital.id
    #     # binding.irb
    #     @staff = Staff.new(staff_params)
    #     # @staff.hospital_id = id
    #     if @staff.save
          redirect_to hospitals_path, notice: t('notice.both_saved')
    #     else
    #       redirect_to new_hospital_staff_path(@form.hospital), notice: t('notice.hospital_saved')
    #     end
    #   else
    #     render :new
    #   end
    else
      render :new
    end
  end

  def show
    @hospital = Hospital.find(params[:id])
    @favorite_hospital = current_patient.favorite_hospitals.find_by(hospital_id: @hospital.id) if patient_signed_in?
  end

  def edit; end

  def update
    @hospital.hospital_labeling.delete_all unless params[:hospital][:hospital_label_ids]
    if @hospital.update(hospital_params)
      redirect_to hospital_path(@form.hospital), notice: t('notice.updated')
    else
      render :edit
    end
  end

  def destroy
    @hospital.destroy
    redirect_to hospitals_path, notice: t('notice.destroyed')
  end

  private
    def ransack_params
      Hospital.ransack(params[:q])
    end

    def hospital_params
      params.fetch(:hospital, {}).permit(
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
