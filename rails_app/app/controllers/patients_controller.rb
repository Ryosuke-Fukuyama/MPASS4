class PatientsController < ApplicationController
  # before_action :authenticate_patient!, except: %i[index]
  before_action :admin_required, only: [:index]
  before_action :set_patient, only: %i[show update destroy]

  def index
    @q = Patient.ransack(params[:q])
    # @health_interviews = HealthInterview.where(hospital_id: @hospital)
    # @patient_ids = @health_interviews.pluck(:patient_id)
    # @patients = Patient.where(id: @patient_ids)
    @patients = Patient.eager_load(:health_interviews)
                       .where(health_interviews: { hospital_id: @hospital })
    @patients = @q ? @q.result : @patient # @q.result if @q.present?
    @patients = @patients.order(created_at: :asc).page(params[:page]).per(8)
  end

  def search
    index
    render :index
  end

  def show
    @patient = current_patient if patient_signed_in?
    if @patient.health_interviews.present?
      @last_interview = @patient.health_interviews.last
      @last_status = @last_interview.guide_status.status
      @hospital = @last_interview.hospital

      if @last_status == 'initial'
        @health_interviews = HealthInterview.where(hospital_id: @hospital)
                                            .where(created_at: Time.current.all_day)
                                            .eager_load(:guide_status)
                                            .where(guide_statuses: { status: 'initial' })
                                            .order(created_at: :asc)
        @index = @health_interviews.map { |a| a[:id] }.find_index(current_patient.id)
        @index += 1
      end
    end
  end

  def destroy
    @patient.destroy
    redirect_to patients_path, notice: t('notice.destroyed')
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
