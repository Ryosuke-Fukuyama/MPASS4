require 'rails_helper'

RSpec.describe Hospital, type: :model do
  describe 'association' do
    it { is_expected.to have_many(:health_interviews) }
    it { is_expected.to have_many(:staffs) }
    it { is_expected.to have_many(:hospital_labelings) }
    it { is_expected.to have_many(:hospital_labels) }
    it { is_expected.to have_many(:favorite_hospitals) }
  end

  describe 'varidation' do
    let!(:hospital) { FactoryBot.create(:hospital, email: 'HoSpiTAL1@mail.com') }

    context 'name' do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_length_of(:name).is_at_least(2) }
      it { is_expected.to validate_length_of(:name).is_at_most(50) }
    end

    context 'email' do
      let!(:hospital_2) { FactoryBot.create(:second_hospital, email: 'hospital1@mail.com') }

      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_length_of(:email).is_at_most(255) }
      it { is_expected.to be_invalid }
    end

    context 'tel' do
      let!(:hospital_2) { FactoryBot.create(:second_hospital, tel: 0o000000001) }

      it { is_expected.to validate_presence_of(:tel) }
      it { is_expected.to validate_numericality_of(:tel).only_integer }
      it { is_expected.to be_invalid }
    end

    context 'address' do
      it { is_expected.to validate_presence_of(:address) }
      it { is_expected.to validate_length_of(:address).is_at_most(255) }
    end

    context 'access' do
      it { is_expected.to validate_presence_of(:access) }
    end
    # context 'before_validation' do
    #   subject { hospital.email }
    #   it { is_expected.to eq 'hospital1@mail.com' }
    # end

    context 'after_validation' do
      let!(:hospital_2) { FactoryBot.create(:second_hospital, address: '兵庫県神戸市中央区加納町１丁目３−１') }

      it 'is valid when appropreate latlng is received with an address' do
        Hospital.geocoded_by :address
        lat = hospital_2.latitude.to_f
        lng = hospital_2.longitude.to_f
        expect(lat).to be_within(0.005).of 34.706705
        expect(lng).to be_within(0.005).of 135.195490
      end
    end
  end
end
