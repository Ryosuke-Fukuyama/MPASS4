class HealthInterviewsController < ApplicationController
  before_action :patient_required, only: [:new]
  before_action :staff_required, only: %i[show edit]
  before_action :set_health_interview_params, only: %i[show edit update destroy]

  def index
    @hospital = Hospital.find(params[:id])
    @health_interviews = HealthInterview.search_today.where(hospital_id: @hospital.id)
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

    if staff_signed_in? && current_staff.hospital_id == @hospital.id
      @session_check = true
    end
  end

  def payment
    @health_interviews = HealthInterview
                          .search_today
                          .where(hospital_id: @hospital)
                          .includes(:guide_status)
                          .order(created_at: :asc)
    @health_interviews_2 = @health_interviews.search_payment if @health_interviews.search_payment.present?
    @health_interviews_4 = @health_interviews.search_noshow if @health_interviews.search_noshow.present?
  end

  def new
    @health_interviews = current_patient.health_interviews
    if @health_interviews.present? && (@health_interviews.last.guide_status.initial? ||
                                        @health_interviews.last.guide_status.calling? ||
                                        @health_interviews.last.guide_status.pending?
                                      )
      redirect_to patient_path(current_patient.id), notice: t('notice.already')
    end
    @history = @health_interviews.where(hospital_id: @hospital)
    @health_interview = HealthInterview.new
    @health_interview.build_guide_status
    binding.irb
  end

  def create
    # @health_interview = current_patient.health_interviews.build(health_interview_params)
    # @hospital.health_interviews << @health_interview
    @health_interview = HealthInterview.create(health_interview_params)
    if @health_interview.save
      redirect_to patient_path(current_patient.id), notice: t('notice.newinterview')
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
    if @health_interview.guide_status.update(status: guide_status_params[:status])
      # @health_interview.number.destroy if status.status == noshow || status.status == complete
      render 'index'
      # , json: { registration: 'OK!' }, status: 200
    else
      render 'index'
      # , json: { registration: 'ERROR!!!' }, status: 500
    end

    # @email = @health_interview.patient.email
    # NotificationMailer.soon_mail(@health_interview, @email).deliver_later if @health_interview.notification?
    # NotificationMailer.bill_mail(@health_interview, @email).deliver if @health_interview.price.present?
  end

  def destroy
    @health_interview.destroy
  end

  private

    def set_health_interview_params
      @health_interview = HealthInterview.find(params[:id])
    end

    def health_interview_params
      params.require(:health_interview).permit(
        :age,
        :gender,
        :symptomatology,
        :condition,
        :comment,
        :price,
        :hospital_id,
        # :notification,
        guide_status_attributes: [
          :id,
          :status
        ]
      ).merge(patient_id: current_patient.id)
    end

    def guide_status_params
      params.require(:guide_status).permit(:id, :status)
    end
end
