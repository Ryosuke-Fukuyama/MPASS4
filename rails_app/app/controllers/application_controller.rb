class ApplicationController < ActionController::Base
  before_action :set_hospital_parms

  def patient_required
    redirect_back(fallback_location: root_path) unless patient_signed_in?
  end

  def staff_required
    redirect_back(fallback_location: root_path) if @hospital.nil?
    redirect_back(fallback_location: health_interviews_path(@hospital)) unless staff_signed_in? && current_staff.hospital_id == @hospital.id
  end

  def admin_required
    redirect_back(fallback_location: root_path) if @hospital.nil?
    redirect_back(fallback_location: health_interviews_path(@hospital)) unless staff_signed_in? && current_staff.admin? && current_staff.hospital_id == @hospital.id
  end

  private
  def set_hospital_parms
    @hospital = Hospital.find(params[:hospital_id]) if params[:hospital_id].present?
    @hospital = Hospital.find(current_staff.hospital_id) if staff_signed_in?
  end
end
