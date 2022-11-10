require 'rails_helper'

RSpec.describe GuideStatus, type: :model do
  describe 'enum status' do
    it { is_expected.to define_enum_for(:status).with_values(
                                                              initial: 0,
                                                              calling: 1,
                                                              pending: 2,
                                                              noshow: 3,
                                                              payment: 4,
                                                              complete: 5
                                                            )
    }
  end

  # #   matcherの前で返してる？ "ArgumentError: 'test' is not a valid status"
  # describe 'enum validation' do
  #   let!(:patient) { FactoryBot.create(:patient) }
  #   let!(:hospital) { FactoryBot.create(:hospital) }
  #   let!(:health_interview) { FactoryBot.create(:health_interview, patient_id: patient.id, hospital_id: hospital.id) }
  #   let!(:guide_status) { FactoryBot.create(:guide_status, health_interview_id: health_interview.id) }
  #   it '指定のシンボル以外は弾く' do
  #     guide_status.status = 'test'
  #     # expect(guide_status).to be_invalid
  #     guide_status.valid?
  #     expect(guide_status.errors.messages[:status]).to include('is not a valid status')
  #   end
  # end
end
