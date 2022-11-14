require 'rails_helper'

RSpec.describe HealthInterview, type: :model do
  describe 'enum gender' do
    it { is_expected.to define_enum_for(:gender).with_values(
                                                              man: 0,
                                                              woman: 1
                                                            )
    }
  end

  # xdescribe 'validation' do
  #   context 'price' do
  #     it { is_expected.to validate_numericality_of(:price) }
  #   end
  # end

  let!(:patient_1) { FactoryBot.create(:patient) }
  let!(:patient_2) { FactoryBot.create(:second_patient) }
  let!(:patient_3) { FactoryBot.create(:third_patient) }
  let!(:patient_4) { FactoryBot.create(:fourth_patient) }
  let!(:patient_5) { FactoryBot.create(:fifth_patient) }
  let!(:hospital) { FactoryBot.create(:hospital) }
  let!(:health_interview_1) { FactoryBot.create(:health_interview, patient_id: patient_1.id, hospital_id: hospital.id) }
  let!(:health_interview_2) { FactoryBot.create(:second_health_interview, patient_id: patient_2.id, hospital_id: hospital.id) }
  let!(:health_interview_3) { FactoryBot.create(:third_health_interview, patient_id: patient_3.id, hospital_id: hospital.id) }
  let!(:health_interview_4) { FactoryBot.create(:health_interview, patient_id: patient_4.id, hospital_id: hospital.id) }
  let!(:health_interview_5) { FactoryBot.create(:health_interview, patient_id: patient_5.id, hospital_id: hospital.id) }
  let!(:guide_status_1) { FactoryBot.create(:guide_status, health_interview_id: health_interview_1.id) }
  let!(:guide_status_2) { FactoryBot.create(:guide_status, status: 'calling', health_interview_id: health_interview_2.id) }
  let!(:guide_status_3) { FactoryBot.create(:guide_status, status: 'pending', health_interview_id: health_interview_3.id) }
  let!(:guide_status_4) { FactoryBot.create(:guide_status, status: 'payment', health_interview_id: health_interview_4.id) }
  let!(:guide_status_5) { FactoryBot.create(:guide_status, status: 'noshow', health_interview_id: health_interview_5.id) }

  describe 'scope' do
    before do
      @health_interviews = HealthInterview.eager_load(:guide_status)
    end
    context 'only initial' do
      subject { @health_interviews.search_initial.sample.guide_status.status }
      it { is_expected.to eq 'initial' }
    end
    context 'only calling' do
      subject { @health_interviews.search_calling.sample.guide_status.status }
      it { is_expected.to eq 'calling' }
    end
    context 'only payment' do
      subject { @health_interviews.search_payment.sample.guide_status.status }
      it { is_expected.to eq 'payment' }
    end
    context 'only pending' do
      subject { @health_interviews.search_pending.sample.guide_status.status }
      it { is_expected.to eq 'pending' }
    end
    context 'only noshow' do
      subject { @health_interviews.search_noshow.sample.guide_status.status }
      it { is_expected.to eq 'noshow' }
    end
    context 'only today' do
      subject { @health_interviews.search_today.sample.created_at }
        it {
          expect(((Time.zone.now - subject) / 1.days).floor).to be < 1
        }
    end
  end
end
