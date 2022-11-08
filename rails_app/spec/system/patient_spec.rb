require 'rails_helper'

RSpec.describe 'Patient', type: :system do
  let!(:patient_1) { FactoryBot.create(:patient) }
  before do
    visit root_path
  end

  describe 'sign_up' do
    subject { page }
    before do
      click_on '新規アカウント'
    end
    context 'Failure' do
      example 'no name' do
        fill_in 'お名前',            with: ''
        fill_in 'Eメール',           with: 'test@mail.com'
        fill_in 'パスワード',         with: 'Pass-W0rd'
        fill_in 'パスワード（確認用）', with: 'Pass-W0rd'
        click_on 'アカウント登録'
        is_expected.to have_content 'お名前を入力してください'
      end
      example 'no email' do
        fill_in 'お名前',            with: 'テスト太郎'
        fill_in 'Eメール',           with: ''
        fill_in 'パスワード',         with: 'Pass-W0rd'
        fill_in 'パスワード（確認用）', with: 'Pass-W0rd'
        click_on 'アカウント登録'
        is_expected.to have_content 'Eメールを入力してください'
      end
      example 'no password' do
        fill_in 'お名前',            with: 'テスト太郎'
        fill_in 'Eメール',           with: 'test@mail.com'
        fill_in 'パスワード',         with: ''
        fill_in 'パスワード（確認用）', with: 'Pass-W0rd'
        click_on 'アカウント登録'
        is_expected.to have_content 'パスワードを入力してください'
      end
      example 'not_eq password' do
        fill_in 'お名前',            with: 'テスト太郎'
        fill_in 'Eメール',           with: 'test@mail.com'
        fill_in 'パスワード',         with: 'Pass-W0rd'
        fill_in 'パスワード（確認用）', with: 'Pass-W01234'
        click_on 'アカウント登録'
        is_expected.to have_content 'パスワード（確認用）とパスワードの入力が一致しません'
      end
      #  #  未実装
      # example 'no check' do
      #   fill_in 'お名前',            with: "テスト太郎"
      #   fill_in 'Eメール',           with: "test@mail.com"
      #   fill_in 'パスワード',         with: "Pass-W0rd"
      #   fill_in 'パスワード（確認用）', with: "Pass-W0rd"
      #   click_on "アカウント登録"
      #   is_expected.to have_content "reCAPTCHA認証に失敗しました"
      # end
    end
    context 'success' do
      example 'fill in all' do
        fill_in 'お名前',             with: 'テスト太郎'
        fill_in 'Eメール',            with: 'test@mail.com'
        fill_in 'パスワード',         with: 'Pass-W0rd'
        fill_in 'パスワード（確認用）', with: 'Pass-W0rd'
        # check '.recaptcha-checkbox-border'
        click_on 'アカウント登録'
        is_expected.to have_content '本人確認用のメールを送信しました。'
      end
    end
  end

  describe 'session' do
    subject { page }
    describe 'sign_in' do
      before do
        click_on 'ログイン'
      end
      context 'Failure' do
        example 'no email' do
          fill_in 'Eメール',   with: ''
          fill_in 'パスワード', with: patient_1.password
          click_button 'ログイン'
          is_expected.to have_content 'Eメールまたはパスワードが違います'
        end
        example 'no password' do
          fill_in 'Eメール',   with: patient_1.email
          fill_in 'パスワード', with: ''
          click_button 'ログイン'
          is_expected.to have_content 'Eメールまたはパスワードが違います'
        end
        xexample 'not confirme' do
          patient = FactoryBot.create(:fourth_patient)
          patient.confirmed_at = nil
          fill_in 'Eメール',   with: patient.email
          fill_in 'パスワード', with: patient.password
          click_button 'ログイン'
          is_expected.to have_content 'メールアドレスの本人確認が必要です'
        end
      end
      context 'success' do
        example '' do
          fill_in 'Eメール',   with: patient_1.email
          fill_in 'パスワード', with: patient_1.password
          click_button 'ログイン'
          is_expected.to have_content 'ログインしました'
          is_expected.to have_content "#{patient_1.name}様のマイページ"
        end
      end
    end
    describe 'sign_out' do
      before do
        sign_in patient_1
        visit patient_path(patient_1)
      end
      it {
        click_link 'ログアウト'
        is_expected.to have_content 'ログアウトしました'
        expect(current_path).to have_content '/patients/sign_in'
      }
    end
  end


  describe 'edit' do
    subject { page }
    before do
      sign_in patient_1
      visit patient_path(patient_1)
      click_link 'アカウント編集'
    end
    context 'Failure' do
      example 'no current_password' do
        fill_in 'お名前',             with: "名前変え太郎"
        fill_in 'Eメール',            with: "edited@mail.com"
        fill_in 'パスワード',         with: "newPass-W0rd"
        fill_in 'パスワード（確認用）', with: "newPass-W0rd"
        fill_in '現在のパスワード',    with: ""
        click_on "更新"
        is_expected.to have_content "現在のパスワードを入力してください"
      end
    end
    context 'success' do
      example 'ok current_password' do
        fill_in 'お名前',             with: "名前変え太郎"
        fill_in 'Eメール',            with: "edited@mail.com"
        fill_in 'パスワード',         with: "newPass-W0rd"
        fill_in 'パスワード（確認用）', with: "newPass-W0rd"
        fill_in '現在のパスワード',    with: patient_1.password
        click_on "更新"
        is_expected.to have_content "アカウント情報を変更しました。"
      end
    end
    context 'account delete' do
      example 'confirm cancel' do
        page.dismiss_confirm("本当によろしいですか？") do
          click_on 'アカウント削除'
        end
        is_expected.not_to have_content "アカウントを削除しました。"
      end
      example 'confirm ok' do
        page.accept_confirm("本当によろしいですか？") do
          click_on 'アカウント削除'
        end
        is_expected.to have_content "アカウントを削除しました。"
        is_expected.to have_content 'このアプリを通して実現したいビジョンは'
      end
    end
  end


  let!(:hospital_1) { FactoryBot.create(:hospital) }

  describe 'favorite hospital' do
    subject { page }
    before do
      sign_in patient_1
      visit patient_path(patient_1)
      click_on '病院一覧'
      first('tbody tr td').click_link
    end
    context 'on -> off' do
      example '' do
        click_on '☆お気に入り追加'
        is_expected.to have_content 'お気に入りに追加しました！'
        click_on '☆お気に入り'
        is_expected.to have_content hospital_1.name
        click_on hospital_1.name
        click_on '☆お気に入り解除'
        is_expected.to have_content 'お気に入りから削除しました！'
        click_on '☆お気に入り'
        is_expected.not_to have_content hospital_1.name
      end
    end
  end

  let!(:patient_2) { FactoryBot.create(:second_patient) }
  let!(:patient_3) { FactoryBot.create(:third_patient) }
  let!(:health_interview_1) { FactoryBot.create(:health_interview, patient_id: patient_2.id, hospital_id: hospital_1.id) }
  let!(:health_interview_2) { FactoryBot.create(:second_health_interview, patient_id: patient_3.id, hospital_id: hospital_1.id) }
  let!(:guide_status_1) { FactoryBot.create(:guide_status, status: 'complete', health_interview_id: health_interview_1.id) }
  let!(:guide_status_2) { FactoryBot.create(:guide_status, health_interview_id: health_interview_2.id) }

  describe 'new health_interview' do
    subject { page }
    context 'success' do
      example 'first new' do
        sign_in patient_1
        visit patient_path(patient_1)
        click_on '病院一覧'
        first('tbody tr td').click_link
        click_link 'オンライン待合室'
        click_on '新規受付はこちら'
        is_expected.to have_content '初診用'
        # fill_in 'symptoms', with:
        click_on '申し込む'
        is_expected.to have_content '受付を完了しました'
        is_expected.to have_content '整理券番号は'
      end
      example 'second new' do
        sign_in patient_2
        visit patient_path(patient_2)
        click_on '病院一覧'
        first('tbody tr td').click_link
        click_link 'オンライン待合室'
        click_on '新規受付はこちら'
        expect(page).to have_content '再診用'
        # fill_in 'symptoms', with:
        click_on '申し込む'
        is_expected.to have_content '受付を完了しました'
      end
    end
    context 'Failure' do
      example 'already new' do
        sign_in patient_3
        visit patient_path(patient_3)
        click_on '病院一覧'
        first('tbody tr td').click_link
        click_link 'オンライン待合室'
        is_expected.not_to have_content '新規受付はこちら'
      end
    end
  end

  #  #  未実装
  # describe 'pay' do
  #   before do
  #     payjp_charge = double('Payjp::Charge')
  #     allow(Payjp::Charge).to receive(:create).and_return(payjp_charge)
  #     allow(payjp_customer).to receive(:id).and_return('cus_xxxxxxxxxxxxx')
  #   end
  #   context 'mock' do
  #     example 'ok' do
  #       post :create, params: { token: 'tok_xxxxxxxx' }
  #       credit = create(:credit, user_id: user.id, customer_id: 'cus_xxxxxxxxxxxxx')
  #       expect(assigns(:credit).customer_id).to eq(credit.customer_id)
  #       expect(page).to have_content 'お支払いが完了しました'
  #     end
  #   end
  # end
end