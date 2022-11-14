require 'rails_helper'

RSpec.describe 'Hospitals', type: :system do
  let!(:hospital_label_1) { FactoryBot.create(:hospital_label, id: 1) }
  let!(:hospital_label_2) { FactoryBot.create(:second_hospital_label, id: 2) }
  let!(:hospital_label_3) { FactoryBot.create(:hospital_label, name: "歯科", id: 3) }
  let!(:hospital_1) { FactoryBot.create(:hospital, hospital_label_ids: [1]) }
  let!(:hospital_2) { FactoryBot.create(:second_hospital, name: 'あ病院', hospital_label_ids: [2]) }
  let!(:hospital_3) { FactoryBot.create(:third_hospital, hospital_label_ids: [3]) }
  # before do
  #   visit root_path
  #   click_on '病院一覧'
  # end

  describe 'index' do
    before do
      visit hospitals_path
    end
    it 'sort name_asc' do
      list_top = first('tbody tr td')
      expect(list_top).to have_content hospital_2.name
    end
    context 'search' do
      subject { page }
      example 'name_search' do
        fill_in '病院名:', with: '第三'
        click_button '検索'
        is_expected.to have_content hospital_3.name
      end
      example 'label_search' do
        select '内科', from: '診療科:'
        click_button '検索'
        is_expected.to have_content hospital_1.name
      end
    end
  end

  describe 'transition' do
    subject { page }
    before do
      visit hospitals_path
    end
    example 'show' do
      first('tbody tr td').click_link
      is_expected.to have_content hospital_2.name
      is_expected.to have_content 'オンライン待合室'
    end
    example 'hospital_health_interviews' do
      first('tbody tr td').click_link
      click_link 'オンライン待合室'
      is_expected.to have_content '予約一覧'
    end
  end
end
