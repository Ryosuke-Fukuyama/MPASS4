require 'rails_helper'

RSpec.describe Patient, type: :model do
  describe 'association' do
    it { is_expected.to have_many(:health_interviews) }
    it { is_expected.to have_many(:sns_credentials) }
    it { is_expected.to have_many(:favorite_hospitals) }
  end

  describe 'varidation' do
    let!(:patient) { FactoryBot.create(:patient, email: 'paTieNT1@mail.com') }

    context 'name' do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_length_of(:name).is_at_least(2) }
      it { is_expected.to validate_length_of(:name).is_at_most(20) }
    end

    context 'email' do
      let!(:patient_2) { FactoryBot.create(:second_patient, email: 'patient1@mail.com') }

      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_length_of(:email).is_at_most(255) }
      it { is_expected.to be_invalid }
    end

    context 'password' do
      it { is_expected.to validate_presence_of(:password).on(:create) }
    end

    context 'tel' do
      it { is_expected.to validate_numericality_of(:tel).only_integer }
    end

    context 'address' do
      it { is_expected.to validate_length_of(:address).is_at_most(255) }
    end
    # context 'before_validation' do
    #   binding.irb
    #   subject { patient.email }
    #   it { is_expected.to eq 'patient1@mail.com' }
    # end
  end
end
