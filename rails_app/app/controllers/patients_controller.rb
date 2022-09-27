class PatientsController < ApplicationController
  # before_action :authenticate_patient!, except: %i[index destroy]
  before_action :admin_required, only: [:index]
  # before_action :set_patient, only: %i[show update destroy]

  def index
    @q = Patient.ransack(params[:q])
    @health_interviews = HealthInterview.where(hospital_id: @hospital.id)
    @patient_ids = @health_interviews.pluck(:patient_id)
    @patients = Patient.where(id: @patient_ids)
    @patients = @q.result if @q.present?
    @patients = @patients.order(created_at: :asc).page(params[:page]).per(8)
  end

  def show
    @patient = current_patient if patient_signed_in?
    # @last_interview = @patient.health_interviews.last
  end

  def update
    @patient = current_patient
    if @patient.update(patient_params)
      redirect_to patient_path, notice: t('notice.updated')
    else
      render 'edit'
    end
  end

  def destroy
    @patient.destroy
    redirect_to patients_path, notice: t('notice.destroyed')
  end

  def sign_in_required
    redirect_to new_patient_session_url unless patient_signed_in? || (staff_signed_in? && current_staff.admin)
  end

  # def pay
  #   Payjp.api_key = ENV['PAYJP_SECRET_KEY']
  #   charge = Payjp::Charge.create(
  #     amount: @last_interview.price,
  #     card: params['payjp-token'],
  #     currency: 'jpy'
  #   )
  #   PaymentMailer.charged_mail(@last_interview).deliver
  #   redirect_to patient_path, notice: t('notice.paied')
  # end

  private

  def set_patient
    @patient = Patient.find(params[:id])
  end

  def patient_params
    params.require(:patient).permit(
      :name,
      :email,
      :password,
      :password_confirmation,
      :tel,
      :address
    )
  end
end
