require 'rails_helper'

RSpec.describe Staff, type: :model do
  describe 'association' do
    it { is_expected.to have_many(:guide_labels) }
  end

  describe 'varidation' do
    # let!(:hospital) { FactoryBot.create(:hospital) }
    # let!(:staff) { FactoryBot.create(:staff, hospital_id: hospital.id) }
    context 'name' do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_length_of(:name).is_at_least(1) }
      it { is_expected.to validate_length_of(:name).is_at_most(20) }
    end

    context 'password' do
      it { is_expected.to validate_presence_of(:password).on(:create) }
    end
  end
end
