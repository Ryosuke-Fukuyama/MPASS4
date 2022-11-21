require 'rails_helper'

RSpec.describe Hospital, type: :model do
  describe 'varidation' do
    let!(:hospital) { FactoryBot.create(:hospital) }

    context 'name' do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_length_of(:name).is_at_most(99) }
    end

    context 'email' do
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_length_of(:email).is_at_most(255) }

      it {
        hospital.email = 'error_test-mail.com'
        is_expected.to be_invalid
      }
    end

    xcontext 'email_downcase' do
      it {
        hospital.email = 'HOSPITAL@Mail.com'
        expect(hospital.email).to be 'hospital@mail.com'
      }
    end

    context 'tel' do
      it { is_expected.to validate_presence_of(:tel) }
      it { is_expected.to validate_length_of(:tel).is_at_least(10) }
      it { is_expected.to validate_length_of(:tel).is_at_most(11) }

      it {
        hospital.tel = '123456789'
        is_expected.to be_invalid
      }
    end

    context 'address' do
      it { is_expected.to validate_presence_of(:address) }
      it { is_expected.to validate_length_of(:address).is_at_most(255) }
    end

    xcontext 'image' do
      # fixture_file_upload('_sample.png')
      # Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/_sample.png'))
      example 'type' do
        text_file = File.open(Rails.root.join('spec/fixtures/sample.text'))
        hospital.images.attach(text_file) # 'Could not find or build blob: expected attachable'
        hospital.valid?
        expect(hospital.errors.messages[:images]).to include '写真はjeg、jpegまたはpng形式でアップロードしてください'
      end
      example 'size' do
        png_file = File.open(Rails.root.join('spec/fixtures/over_size_sample.png'))
        hospital.images.attach(png_file)
        hospital.valid?
        expect(hospital.errors.messages[:images]).to include '写真は1つのファイル100KB以内にしてください'
      end
      example 'length' do
        jpg_file = File.open(Rails.root.join('spec/fixtures/under_size_sample.jpg'))
        hospital.images.attach(jpg_file)
        hospital.images.attach(jpg_file)
        hospital.images.attach(jpg_file)
        hospital.images.attach(jpg_file)
        hospital.images.attach(jpg_file)
        hospital.images.attach(jpg_file)
        hospital.valid?
        expect(hospital.errors.messages[:images]).to include '写真は5枚以内になるよう調整してください'
      end
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
