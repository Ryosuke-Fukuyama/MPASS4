class ApplicationController < ActionController::Base
  before_action :set_hospital_parms

  def patient_required
    redirect_back(fallback_location: root_path) if !patient_signed_in?
  end

  def staff_required # 一行文だとnil classエラーでる
    if !staff_signed_in?
      redirect_back(fallback_location: root_path)
    elsif !current_staff.hospital_id == @hospital.id
      redirect_back(fallback_location: health_interviews_path(@hospital))
    end
  end

  def admin_required
    if !(staff_signed_in? || master_signed_in?)
      redirect_back(fallback_location: root_path)
    elsif !((staff_signed_in? && current_staff.admin? && current_staff.hospital_id == @hospital.id) || master_signed_in?)
      redirect_back(fallback_location: health_interviews_path(@hospital))
    end
  end

  def master_required
    redirect_back(fallback_location: root_path) if !master_signed_in?
  end

  private

  def set_hospital_parms
    if @hospital.nil?
      if params[:hospital_id].present?
        @hospital = Hospital.find(params[:hospital_id])
      elsif staff_signed_in?
        @hospital = Hospital.find(current_staff.hospital_id)
      elsif params[:controller] == "hospitals" && params[:id].present?
        @hospital = Hospital.find(params[:id])
      end
    end
  end
end
