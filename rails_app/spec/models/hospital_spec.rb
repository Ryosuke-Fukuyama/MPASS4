require 'rails_helper'

RSpec.describe Hospital, type: :model do
  describe 'varidation' do
    context 'name' do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_length_of(:name).is_at_most(99) }
    end

    context 'email' do
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_length_of(:email).is_at_most(255) }

      # let!(:hospital) { FactoryBot.create(:hospital, email: 'error_test-mail.com') }
      # it { is_expected.to be_invalid }
    end

    # context 'email_downcase' do
    #   let!(:hospital) { FactoryBot.create(:hospital, email: 'HOSPITAL@Mail.com') }
    #   it {
    #     expect(hospital.email).to be 'hospital@mail.com'
    #   }
    # end

    context 'tel' do
      it { is_expected.to validate_presence_of(:tel) }
      it { is_expected.to validate_length_of(:tel).is_at_least(10) }
      it { is_expected.to validate_length_of(:tel).is_at_most(11) }

      # let!(:hospital) { FactoryBot.create(:hospital, tel: 123456789) }
      # it { is_expected.to be_invalid }
    end

    context 'address' do
      it { is_expected.to validate_presence_of(:address) }
      it { is_expected.to validate_length_of(:address).is_at_most(255) }
    end

    # # 未実装箇所
    # context 'map after_validation' do
    #   let!(:hospital_2) { FactoryBot.create(:second_hospital, address: '兵庫県神戸市中央区加納町１丁目３−１') }

    #   it 'is valid when appropreate latlng is received with an address' do
    #     Hospital.geocoded_by :address
    #     lat = hospital_2.latitude.to_f
    #     lng = hospital_2.longitude.to_f
    #     expect(lat).to be_within(0.005).of 34.706705
    #     expect(lng).to be_within(0.005).of 135.195490
    #   end
    # end
  end
end
