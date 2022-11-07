require 'rails_helper'

RSpec.describe 'Tops', type: :system do
  let!(:hospital_label) { FactoryBot.create(:hospital_label, id: 1) }
  let!(:hospital) { FactoryBot.create(:hospital, id: 1, hospital_label_ids: [1]) }

  describe 'guest_sign_in' do
    subject { page }
    before do
      visit root_path
      click_link '使い方'
    end
    example 'patient' do
      click_on 'ゲストユーザー'
      is_expected.to have_content 'ゲストユーザーとしてログインしました.'
    end

    example 'staff' do
      click_on 'ゲストスタッフ'
      is_expected.to have_content 'ゲストスタッフとしてログインしました。'
    end

    example 'admin staff' do
      click_on 'ゲスト管理スタッフ'
      is_expected.to have_content 'ゲスト管理スタッフとしてログインしました。'
    end

    example 'master' do
      click_on 'ゲストマスター'
      is_expected.to have_content 'ゲストマスターとしてログインしました。'
    end
  end
end

