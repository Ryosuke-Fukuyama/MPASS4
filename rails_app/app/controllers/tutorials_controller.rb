class TutorialsController < ApplicationController
  def index; end

  def guest_sign_in
    patient = Patient.find_or_create_by!(email: 'guest@example.com') do |patient|
      patient.name = 'ゲスト'
      patient.password = generate_password
      patient.password_confirmation = patient.password
      patient.confirmed_at = Time.now
    end
    sign_in patient
    redirect_to patient_path(current_patient.id), notice: t('notice.guest_patient')
  end

  def guest_staff_sign_in
    staff = Staff.find_or_create_by!(name: 'ゲストスタッフ') do |staff|
      staff.password = generate_password
      staff.password_confirmation = staff.password
      staff.hospital_id = 1
    end
    sign_in staff
    redirect_to health_interviews_path(staff.hospital_id), notice: t('notice.guest_staff')
  end

  def guest_admin_sign_in
    staff = Staff.find_or_create_by!(name: 'ゲストアドミン') do |staff|
      staff.admin = true
      staff.password = generate_password
      staff.password_confirmation = staff.password
      staff.hospital_id = 1
    end
    sign_in staff
    redirect_to hospital_path(staff.hospital_id), notice: t('notice.guest_admin_staff')
  end

  def guest_master_sign_in
    master = Master.find_or_create_by!(email: 'guest_master@example.com') do |master|
      master.name = 'ゲストマスター'
      master.password = generate_password
      master.password_confirmation = master.password
      master.confirmed_at = Time.now
    end
    sign_in master
    redirect_to hospitals_path, notice: t('notice.guest_master')
  end

  private

  def generate_password(length = 19)
    symbols = [
      '!', '"', '#', '$', '%', '&', "'", '(', ')', '=', '~',
      '|', '-', '^', '@', '`', '+', '*', '<', '>', '_'
    ]
    seed = ('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a + symbols
    str = ''

    str += seed[rand(seed.length)].to_s while str.length < length

    str
  end
end
