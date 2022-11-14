require 'rails_helper'

RSpec.describe Staff, type: :model do
  describe 'varidation' do
    context 'name' do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_length_of(:name).is_at_least(2) }
      it { is_expected.to validate_length_of(:name).is_at_most(20) }
    end

    context 'password' do
      it { is_expected.to validate_presence_of(:password).on(:create) }
    end
  end
end
