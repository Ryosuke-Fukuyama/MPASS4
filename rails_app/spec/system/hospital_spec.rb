require 'rails_helper'

RSpec.describe 'Hospitals', type: :system do
  let!(:hospital_1) { FactoryBot.create(:hospital, id: 1, hospital_label_ids: [1]) }
  let!(:hospital_2) { FactoryBot.create(:second_hospitalhospital_label_ids: [2]) }
  let!(:hospital_3) { FactoryBot.create(:third_hospital)hospital_label_ids: [3] }
  let!(:hospital_label_1) { FactoryBot.create(:hospital_label) }
  let!(:hospital_label_2) { FactoryBot.create(:hospital_label, name: "外科") }
  let!(:hospital_label_3) { FactoryBot.create(:hospital_label, name: "歯科") }

  describe 'index' do
    before do
      visit root_path
      click_on '病院一覧'
      @list_top = first("")
    end
    context 'sort name_asc' do
      subject { @list_top }
      it { is_expected.to have_content hospital_1.name }
    end
    context 'search' do
      example 'name_search' do
        subject { page }
        befor do
          fill_in q_name_cont: hospital_2.name
          click_on '検索する'
        end
        it { is_expected.to have_content hospital_2.name }
      end
      # example 'label_search' do
      #   subject { page }
      #   befor do
      #     select hospital_label_1.name, form: "#q_hospital_labels_id_eq"
      #     click_on '検索する'
      #   end
      #   it { is_expected.to have_content hospital_3.name }
      # end
    end
  end

  describe 'guest_login' do
    before do
      visit root_path
      click_on '使い方'
    end

    context 'guest_patient' do
      example 'in' do
        click_on 'ゲストユーザー'
        expect(page).to have_content 'ゲストユーザーとしてログインしました。'
      end
    end

    context 'guest_staff' do
      example 'in' do
        click_on 'ゲストスタッフ'
        expect(page).to have_content 'ゲストスタッフとしてログインしました。'
      end
    end

    context 'guest_admin_staff' do
      example '' do
        click_on 'ゲスト管理スタッフ'
        expect(page).to have_content 'ゲスト管理スタッフとしてログインしました。'
      end
    end
  end

  # describe 'redirect' do
  #   before do
  #     visit root_path
  #   end
  #   example '' do
  #   end

  #   example '' do
  #   end

  #   example '' do
  #   end

  #   example '' do
  #   end

  #   example '' do
  #   end
  # end
end
