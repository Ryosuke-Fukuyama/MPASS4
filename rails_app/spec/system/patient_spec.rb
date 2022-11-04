require 'rails_helper'

RSpec.describe 'Patient', type: :system do
  let!(:patient) { FactoryBot.create(:patient, email: 'patient0@mail.com') }
  let!(:patient_0) { FactoryBot.create(:patient, confirmed_at: Time.now) }
  let!(:patient_1) { FactoryBot.create(:second_patient) }
  let!(:patient_5) { FactoryBot.create(:sixth_patient) }
  let!(:hospital) { FactoryBot.create(:hospital) }
  let!(:health_interview_0) { FactoryBot.create(:health_interview, patient_id: patient_0.id, hospital_id: hospital.id) }
  let!(:guide_label_0) { FactoryBot.create(:guide_label, health_interview_id: health_interview_0.id) }
  let!(:health_interview_5) { FactoryBot.create(:health_interview, patient_id: patient_5.id, hospital_id: hospital.id) }
  let!(:guide_label_5) { FactoryBot.create(:guide_label, status: 'complete', health_interview_id: health_interview_5.id) }

  ## before do
  ##   visit root_path
  ## end

  # describe 'certification' do

  #   describe 'sign_up' do
  #     subject { current_path }

  #     before do
  #       visit root_path
  #       click_on '新規アカウント'
  #     end

  #     it { is_expected.to have_content '/patients/sign_up' }

  #     context 'Failure' do
  #       example 'no name' do
  #         fill_in :patient_name,                  with: ''
  #         fill_in :patient_email,                 with: 'test@mail.com'
  #         fill_in :patient_password,              with: 'password123'
  #         fill_in :patient_password_confirmation, with: 'password123'
  #         click_on 'アカウント登録'
  #         expect(page).to have_content 'お名前を入力してください'
  #       end

  #       example 'no email' do
  #         fill_in :patient_name,                  with: 'test_patient'
  #         fill_in :patient_email,                 with: ''
  #         fill_in :patient_password,              with: 'password123'
  #         fill_in :patient_password_confirmation, with: 'password123'
  #         click_on 'アカウント登録'
  #         expect(page).to have_content 'Eメールを入力してください'
  #       end

  #       example 'no password' do
  #         fill_in :patient_name,                  with: 'test_patient'
  #         fill_in :patient_email,                 with: 'test@mail.com'
  #         fill_in :patient_password,              with: ''
  #         fill_in :patient_password_confirmation, with: 'password123'
  #         click_on 'アカウント登録'
  #         expect(page).to have_content 'パスワードを入力してください'
  #       end

  #       example 'not eq password ' do
  #         fill_in :patient_name,                  with: 'test_patient'
  #         fill_in :patient_email,                 with: 'test@mail.com'
  #         fill_in :patient_password,              with: 'password123'
  #         fill_in :patient_password_confirmation, with: 'password987'
  #         click_on 'アカウント登録'
  #         expect(page).to have_content 'パスワード（確認用）とパスワードの入力が一致しません'
  #       end

  #     #   example 'no check' do
  #     #     fill_in :patient_name,                  with: "test_patient"
  #     #     fill_in :patient_email,                 with: "test@mail.com"
  #     #     fill_in :patient_password,              with: "password123"
  #     #     fill_in :patient_password_confirmation, with: "password123"
  #     #     click_on "アカウント登録"
  #     #     expect(page).to have_content "reCAPTCHA認証に失敗しました"
  #     #   end
  #     end

  #     context 'success' do
  #       example 'fill in all' do
  #         fill_in :patient_name,                  with: 'test_patient'
  #         fill_in :patient_email,                 with: 'test@mail.com'
  #         fill_in :patient_password,              with: 'password123'
  #         fill_in :patient_password_confirmation, with: 'password123'
  #         # check '.recaptcha-checkbox-border'
  #         click_on 'アカウント登録'
  #         expect(page).to have_content '本人確認用のメールを送信しました'
  #       end
  #     end
  #   end

  #   describe 'session' do
  #     describe 'sign_in' do
  #       before do
  #         click_on 'ログイン'
  #       end

  #       context 'Failure' do
  #         example 'no name both email' do
  #           fill_in :patient_login,    with: ''
  #           fill_in :patient_password, with: patient_0.password
  #           find('#submit').click
  #           expect(page).to have_content 'IDまたはパスワードが違います'
  #         end

  #         example 'no password' do
  #           fill_in :patient_login,    with: patient_0.name
  #           fill_in :patient_password, with: ''
  #           find('#submit').click
  #           expect(page).to have_content 'IDまたはパスワードが違います'
  #         end

  #         example 'not confirme' do
  #           fill_in :patient_login,    with: patient.name
  #           fill_in :patient_password, with: patient.password
  #           find('#submit').click
  #           expect(page).to have_content 'メールアドレスの本人確認が必要です'
  #         end
  #       end

  #       context 'success ->transition my_page' do
  #         example 'name in' do
  #           fill_in :patient_login,    with: patient_1.name
  #           fill_in :patient_password, with: patient_1.password
  #           find('#submit').click
  #           expect(page).to have_content 'ログインしました'
  #           expect(current_path).to have_content "/patients/#{patient_1.id}"
  #         end

  #         example 'email in' do
  #           fill_in :patient_login,    with: patient_1.email
  #           fill_in :patient_password, with: patient_1.password
  #           find('#submit').click
  #           expect(page).to have_content 'ログインしました'
  #           expect(current_path).to have_content "/patients/#{patient_1.id}"
  #         end
  #       end
  #     end

  #     describe 'sign_out' do
  #       context 'success ->transition new_session' do
  #         example 'only_case' do
  #           click_on 'ログイン'
  #           fill_in :patient_login,    with: patient_1.email
  #           fill_in :patient_password, with: patient_1.password
  #           find('#submit').click
  #           click_on 'ログアウト'
  #           expect(page).to have_content 'ログアウトしました'
  #           expect(current_path).to have_content '/patients/sign_in'
  #         end
  #       end
  #     end
  #   end
  # end

  # describe 'edit' do
  #   subject { current_path }

  #   before do
  #     visit root_path
  #     click_on 'ログイン'
  #     fill_in :patient_login,    with: patient_1.email
  #     fill_in :patient_password, with: patient_1.password
  #     find('#submit').click
  #     click_on 'アカウント編集'
  #   end

  #   it { is_expected.to have_content "/patients/edit.#{patient_1.id}" }

  #   context 'Failure' do
  #     example 'no password' do
  #       fill_in :patient_name,                  with: "患者次郎改"
  #       fill_in :patient_email,                 with: "edited@mail.com"
  #       fill_in :patient_password,              with: "newpass123"
  #       fill_in :patient_password_confirmation, with: "newpass123"
  #       fill_in :patient_current_password,      with: ""
  #       click_on "更新"
  #       expect(page).to have_content "現在のパスワードを入力してください"
  #     end
  #   end
  #   context 'success' do
  #     example 'ok current_password' do
  #       fill_in :patient_name,                  with: "患者次郎改"
  #       fill_in :patient_email,                 with: "edited@mail.com"
  #       fill_in :patient_password,              with: "newpass123"
  #       fill_in :patient_password_confirmation, with: "newpass123"
  #       fill_in :patient_current_password,      with: patient_1.password
  #       click_on "更新"
  #       expect(page).to have_content "アカウント情報を変更しました。"
  #     end
  #   end
  #   context 'account delete' do
  #     example 'confirm cancel' do
  #       page.dismiss_confirm("本当によろしいですか？") do
  #         click_on 'アカウント削除'
  #       end
  #       expect(current_path).to have_content "/patients/edit.#{patient_1.id}"
  #     end
  #     example 'confirm ok' do
  #       page.accept_confirm("本当によろしいですか？") do
  #         click_on 'アカウント削除'
  #       end
  #       expect(page).to have_content "アカウントを削除しました。"
  #       expect(page).to have_content 'トップページ'
  #     end
  #   end
  # end

  # describe 'new health_interview' do
  #   before do
  #     visit root_path
  #     click_on 'ログイン'
  #   end
  #   context 'success' do
  #     example 'first new' do
  #       fill_in :patient_login,    with: patient_1.email
  #       fill_in :patient_password, with: patient_1.password
  #       find('#submit').click
  #       visit hospital_path(hospital.id)
  #       click_on 'オンライン待合室'
  #       click_on '新規受付はこちら'
  #       expect(page).to have_content '初診用'
  #       click_on '申し込む'
  #       expect(page).to have_content '受付を完了しました'
  #       expect(current_path).to have_content "/patients/#{patient_1.id}"
  #     end
  #     example 'second new' do
  #       fill_in :patient_login,    with: patient_5.email
  #       fill_in :patient_password, with: patient_5.password
  #       find('#submit').click
  #       visit hospital_path(hospital.id)
  #       click_on 'オンライン待合室'
  #       click_on '新規受付はこちら'
  #       expect(page).to have_content '再診用'
  #       click_on '申し込む'
  #       expect(page).to have_content '受付を完了しました'
  #       expect(current_path).to have_content "/patients/#{patient_5.id}"
  #     end
  #   end
  #   context 'Failure' do
  #     example 'already new' do
  #       fill_in :patient_login,    with: patient_0.email
  #       fill_in :patient_password, with: patient_0.password
  #       find('#submit').click
  #       visit hospital_path(hospital.id)
  #       click_on 'オンライン待合室'
  #       expect(page).not_to have_content '新規受付はこちら'
  #     end
  #   end
  # end

  # describe 'status' do
  #   let!(:patient_2) { FactoryBot.create(:third_patient) }
  #   let!(:patient_3) { FactoryBot.create(:fourth_patient) }
  #   let!(:patient_4) { FactoryBot.create(:fifth_patient) }
  #   let!(:health_interview_1) { FactoryBot.create(:health_interview, patient_id: patient_1.id, hospital_id: hospital.id) }
  #   let!(:health_interview_2) { FactoryBot.create(:health_interview, patient_id: patient_2.id, hospital_id: hospital.id) }
  #   let!(:health_interview_3) { FactoryBot.create(:health_interview, patient_id: patient_3.id, hospital_id: hospital.id) }
  #   let!(:health_interview_4) { FactoryBot.create(:health_interview, patient_id: patient_4.id, hospital_id: hospital.id) }
  #   let!(:guide_label_1) { FactoryBot.create(:guide_label, status: 'calling', health_interview_id: health_interview_1.id) }
  #   let!(:guide_label_2) { FactoryBot.create(:guide_label, status: 'done',    health_interview_id: health_interview_2.id) }
  #   let!(:guide_label_3) { FactoryBot.create(:guide_label, status: 'pending', health_interview_id: health_interview_3.id) }
  #   let!(:guide_label_4) { FactoryBot.create(:guide_label, status: 'noshow',  health_interview_id: health_interview_4.id) }

  #   before do
  #     visit root_path
  #     click_on 'ログイン'
  #   end
  #   context 'message' do
  #     example 'initial' do
  #       fill_in :patient_login,    with: patient_0.email
  #       fill_in :patient_password, with: patient_0.password
  #       find('#submit').click
  #       expect(page).to have_content "お申し込み頂きありがとうございます。"
  #     end
  #     example 'calling' do
  #       fill_in :patient_login,    with: patient_1.name
  #       fill_in :patient_password, with: patient_1.password
  #       find('#submit').click
  #       expect(page).to have_content "こちらの画面をご提示の上、"
  #     end
  #     example 'done' do
  #       fill_in :patient_login,    with: patient_2.name
  #       fill_in :patient_password, with: patient_2.password
  #       find('#submit').click
  #       expect(page).to have_content "ご不便をお掛けして申し訳ありません。"
  #     end
  #     example 'pending' do
  #       fill_in :patient_login,    with: patient_3.name
  #       fill_in :patient_password, with: patient_3.password
  #       find('#submit').click
  #       expect(page).to have_content "お呼び出しさせて頂きましたが"
  #     end
  #     example 'noshow' do
  #       fill_in :patient_login,    with: patient_4.name
  #       fill_in :patient_password, with: patient_4.password
  #       find('#submit').click
  #       expect(page).to have_content "お呼び出しから一定時間内に"
  #     end
  #     example 'complete' do
  #       fill_in :patient_login,    with: patient_5.name
  #       fill_in :patient_password, with: patient_5.password
  #       find('#submit').click
  #       expect(page).to have_content "お支払いが確認できました。"
  #     end
  #   end
  # end

  # describe 'favorit' do
  #   before do
  #     visit root_path
  #     click_on 'ログイン'
  #     fill_in :patient_login,    with: patient_1.email
  #     fill_in :patient_password, with: patient_1.password
  #     find('#submit').click
  #     click_on '病院一覧'
  #     find("#hospital-index_#{hospital.id}-show").click
  #   end
  #   context 'index' do
  #     example 'favorite on & off' do
  #       click_on 'お気に入り追加する'
        # click_on 'お気に入り'
        # expect(page).to have_content hospital.name
        # click_on '病院一覧'
        # find("#hospital-index_#{hospital.id}-show").click
  #       binding.irb
  #       click_on 'お気に入り取り消す'
  #       click_on 'お気に入り'
  #       expect(page).not_to have_content hospital.name
  #     end
  #   end
  # end

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
