class FavoriteHospitalsController < ApplicationController
  before_action :patient_required

  def index
    @favorite_hospitals = current_patient.favorite_hospitals.all.order(created_at: :desc)
  end

  def create
    favorite = current_patient.favorite_hospitals.create(hospital_id: params[:hospital_id])
    redirect_to hospital_path(@hospital), notice: favorite.hospital.name.to_s + t('notice.on_favorite')
  end

  def destroy
    favorite = current_patient.favorite_hospitals.find_by(id: params[:id]).destroy
    id = favorite.hospital.id
    redirect_to hospital_path(id), notice: favorite.hospital.name.to_s + t('notice.off_favorite')
  end
end
