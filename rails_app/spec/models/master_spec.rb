require 'rails_helper'

RSpec.describe Master, type: :model do
  describe 'varidation' do
    let!(:master) { FactoryBot.create(:master) }
    context 'name' do
      it { is_expected.to validate_presence_of(:name) }
      xit { is_expected.to validate_uniqueness_of(:name) }
      it { is_expected.to validate_length_of(:name).is_at_least(2) }
      it { is_expected.to validate_length_of(:name).is_at_most(20) }
    end

    context 'email' do
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_length_of(:email).is_at_most(255) }

      xit '正規表現' do
        master.email = ''
        is_expected.to be_invalid
      end
    end

    context 'password' do
      it { is_expected.to validate_presence_of(:password).on(:create) }

      xit '正規表現' do
        master.password = ''
        is_expected.to be_invalid
      end
    end
  end
end
