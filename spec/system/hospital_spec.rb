require 'rails_helper'

RSpec.describe 'Hospitals', type: :system do
  let!(:hospital_label_1) { FactoryBot.create(:hospital_label, id: 1) }
  let!(:hospital_label_2) { FactoryBot.create(:second_hospital_label, id: 2) }
  let!(:hospital_label_3) { FactoryBot.create(:hospital_label, name: "歯科", id: 3) }
  let!(:hospital_1) { FactoryBot.create(:hospital, hospital_label_ids: [1]) }
  let!(:hospital_2) { FactoryBot.create(:second_hospital, name: 'あ病院', hospital_label_ids: [2]) }
  let!(:hospital_3) { FactoryBot.create(:third_hospital, hospital_label_ids: [3]) }
  let!(:admin_staff) { FactoryBot.create(:admin_staff, hospital_id: hospital_1.id) }
  let!(:master) { FactoryBot.create(:master) }
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

  describe 'new' do
    subject { page }
    before do
      sign_in master
      visit new_hospital_path
    end
    context 'Failure' do
      example 'no name' do
        fill_in '病院名',        with: ''
        fill_in 'メールアドレス', with: 'test@mail.com'
        fill_in '電話番号',      with: '1234567890'
        fill_in '住所',          with: 'テスト県スペック市1-2-3'
        click_on '登録'
        is_expected.to have_content '病院名を入力してください'
      end
      example 'no email' do
        fill_in '病院名',        with: 'テスト病院'
        fill_in 'メールアドレス', with: ''
        fill_in '電話番号',      with: '1234567890'
        fill_in '住所',          with: 'テスト県スペック市1-2-3'
        click_on '登録'
        is_expected.to have_content 'メールアドレスを入力してください'
      end
      example 'no tel' do
        fill_in '病院名',        with: 'テスト病院'
        fill_in 'メールアドレス', with: 'test@mail.com'
        fill_in '電話番号',      with: ''
        fill_in '住所',          with: 'テスト県スペック市1-2-3'
        click_on '登録'
        is_expected.to have_content '電話番号を入力してください'
      end
      example 'no address' do
        fill_in '病院名',        with: 'テスト病院'
        fill_in 'メールアドレス', with: 'test@mail.com'
        fill_in '電話番号',      with: '1234567890'
        fill_in '住所',          with: ''
        click_on '登録'
        is_expected.to have_content '住所を入力してください'
      end
    end
    context 'Success' do
      example 'fill in must all' do
        fill_in '病院名',        with: 'テスト病院'
        fill_in 'メールアドレス', with: 'test@mail.com'
        fill_in '電話番号',      with: '1234567890'
        fill_in '住所',          with: 'テスト県スペック市1-2-3'
        click_on '登録'
        is_expected.to have_content '新規登録しました！'
      end
      xexample 'attach images' do
        fill_in '病院名',        with: 'テスト病院'
        fill_in 'メールアドレス', with: 'test@mail.com'
        fill_in '電話番号',      with: '1234567890'
        fill_in '住所',          with: 'テスト県スペック市1-2-3'
        attach_file 'hospital[images][]', File.join(Rails.root, 'spec/fixtures/under_size_sample.jpg')
        click_on '登録'
        click_link 'テスト病院'
        is_expected.not_to have_content 'no_image' # 意味なし
      end
      xexample 'check label' do
        fill_in '病院名',        with: 'テスト病院'
        fill_in 'メールアドレス', with: 'test@mail.com'
        fill_in '電話番号',      with: '1234567890'
        fill_in '住所',          with: 'テスト県スペック市1-2-3'
        check '#hospital_hospital_label_ids_1'
        check '#hospital_hospital_label_ids_2'
        click_on '登録'
        is_expected.to have_content '新規登録しました！'
        # is_expected.to have_content 'テスト科'
      end
    end
  end
end

