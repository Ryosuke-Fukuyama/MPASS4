class HealthInterviewsController < ApplicationController
  before_action :patient_required, only: [:new]
  before_action :staff_required, only: %i[show edit reverse]
  before_action :set_health_interview_params, only: %i[show edit update destroy]
  before_action :set_hospital_params, only: %i[index reverse]
  before_action :set_staff_session_params, only: %i[index reverse]

  def index
    @health_interviews = HealthInterview.search_today.where(hospital_id: @hospital)
    if @health_interviews.present?
      @health_interviews = @health_interviews.eager_load(:guide_status).order(created_at: :asc)
      @health_interviews_0 = @health_interviews.search_initial if @health_interviews.search_initial.any?
      @health_interviews_1 = @health_interviews.search_calling if @health_interviews.search_calling.any?
      @health_interviews_2 = @health_interviews.search_pending if @health_interviews.search_pending.any?
    end

    if patient_signed_in? && current_patient.health_interviews.present?
      @reserved = current_patient.health_interviews
      @last_status = @reserved.last.guide_status
    end
  end

  def reverse
    @health_interviews = HealthInterview.search_today
                                        .where(hospital_id: @hospital)
                                        .eager_load(:guide_status)
                                        .order(updated_at: :asc)
    @health_interviews_3 = @health_interviews.search_noshow if @health_interviews.search_noshow.any?
    @health_interviews_4 = @health_interviews.search_payment if @health_interviews.search_payment.any?
  end

  def new
    @health_interviews = current_patient.health_interviews
    if @health_interviews.present? && (@health_interviews.last.guide_status.initial? ||
                                        @health_interviews.last.guide_status.calling? ||
                                        @health_interviews.last.guide_status.pending? ||
                                        @health_interviews.last.guide_status.payment?
                                      )
      redirect_to patient_path(current_patient.id), alert: t('alert.already')
    end
    @history = @health_interviews.where(hospital_id: params[:id])
    @health_interview = HealthInterview.new
    @health_interview.build_guide_status
  end

  def create
    @health_interview = HealthInterview.create(health_interview_params)
    @health_interview.patient_id = current_patient.id
    @health_interview.hospital_id = params[:id]
    if @health_interview.save
      redirect_to patient_path(current_patient.id), notice: t('notice.new_interview')
    else
      render :new
    end
  end

  def show
    @patient = @health_interview.patient
    @history = @patient.health_interviews.where(hospital_id: @hospital.id)
    @first_interview = @history.first
  end

  def edit; end

  def update
    if params[:guide_status].present?
      @health_interview.guide_status.update(status: guide_status_params[:status])
      @health_interviews_0 = HealthInterview.search_today
                                            .where(hospital_id: @hospital)
                                            .eager_load(:guide_status)
                                            .search_initial
                                            .order(created_at: :asc)
      binding.irb
      @third_patient = @health_interviews_0[3 - 1]
      @email = @third_patient.email
      unless @third_patient.notification?
        NotificationMailer.with(to: @email, hospital_name: @hospital.name).calling_soon.deliver_now
      end
    end
    if health_interview_params[:price].present?
      if @health_interview.update(health_interview_params)
        # NotificationMailer.bill_mail(@health_interview, @email).deliver
        # @health_interview.number.destroy if status.status == noshow || status.status == complete
        redirect_to health_interview_path(@hospital, @health_interview), notice: t('notice.updated') # , json: { registration: 'OK!' }, status: 200
      else
        render 'edit' # , json: { registration: 'ERROR!!!' }, status: 500
      end
    end
  end

  def destroy
    @health_interview.destroy
  end

  private

  def set_health_interview_params
    @health_interview = HealthInterview.find(params[:id])
  end

  def set_hospital_params
    @hospital = Hospital.find(params[:id])
  end

  def set_staff_session_params
    @session_check = true if staff_signed_in? && current_staff.hospital_id == @hospital.id
  end

  def health_interview_params
    params.require(:health_interview).permit(
      :age,
      :gender,
      :symptoms,
      :condition,
      :comment,
      :price,
      :hospital_id,
      # :notification,
      guide_status_attributes: %i[
        id
        status
      ]
    )
  end

  def guide_status_params
    params.require(:guide_status).permit(:id, :status)
  end
end
