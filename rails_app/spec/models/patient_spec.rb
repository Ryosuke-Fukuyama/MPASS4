require 'rails_helper'

RSpec.describe Patient, type: :model do
  describe 'varidation' do
    context 'name' do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_length_of(:name).is_at_least(2) }
      it { is_expected.to validate_length_of(:name).is_at_most(20) }
    end

    context 'email' do
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_length_of(:email).is_at_most(255) }
    end

    context 'password' do
      it { is_expected.to validate_presence_of(:password).on(:create) }
    end

    context 'tel' do
      it { is_expected.to validate_length_of(:tel).is_at_least(10) }
      it { is_expected.to validate_length_of(:tel).is_at_most(11) }
    end

    context 'address' do
      it { is_expected.to validate_length_of(:address).is_at_most(255) }
    end
  end
end
