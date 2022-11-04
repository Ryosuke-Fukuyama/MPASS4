require 'rails_helper'

RSpec.describe HospitalLabel, type: :model do
  describe 'association' do
    it { is_expected.to have_many(:hospital_labelings) }
    it { is_expected.to have_many(:hospitals) }
  end
end
