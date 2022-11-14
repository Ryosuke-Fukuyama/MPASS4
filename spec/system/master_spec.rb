require 'rails_helper'

RSpec.describe 'Master', type: :system do
  let!(:master) { FactoryBot.create(:master) }
  let!(:delete_verify_env_test){ Recaptcha.configuration.skip_verify_env.delete("test") }

  describe 'sign_up' do
    subject { page }
    before do
      visit new_master_registration_path
    end
    context 'Failure' do
      example 'no name' do
        fill_in :master_name,                  with: ''
        fill_in :master_email,                 with: 'test@mail.com'
        fill_in :master_password,              with: 'Pass-W0rd'
        fill_in :master_password_confirmation, with: 'Pass-W0rd'
        click_on 'アカウント登録'
        is_expected.to have_content 'エラーが発生したため マスター は保存されませんでした。'
      end
      example 'no email' do
        fill_in :master_name,                  with: 'テスト太郎'
        fill_in :master_email,                 with: ''
        fill_in :master_password,              with: 'Pass-W0rd'
        fill_in :master_password_confirmation, with: 'Pass-W0rd'
        click_on 'アカウント登録'
        is_expected.to have_content 'エラーが発生したため マスター は保存されませんでした。'
      end
      example 'no password' do
        fill_in :master_name,                  with: 'テスト太郎'
        fill_in :master_email,                 with: 'test@mail.com'
        fill_in :master_password,              with: ''
        fill_in :master_password_confirmation, with: 'Pass-W0rd'
        click_on 'アカウント登録'
        is_expected.to have_content 'エラーが発生したため マスター は保存されませんでした。'
      end
      example 'not_eq password' do
        fill_in :master_name,                  with: 'テスト太郎'
        fill_in :master_email,                 with: 'test@mail.com'
        fill_in :master_password,              with: 'Pass-W0rd'
        fill_in :master_password_confirmation, with: 'Pass-W01234'
        click_on 'アカウント登録'
        is_expected.to have_content 'エラーが発生したため マスター は保存されませんでした。'
      end
      example 'no check' do
        fill_in :master_name,                  with: "テスト太郎"
        fill_in :master_email,                 with: "test@mail.com"
        fill_in :master_password,              with: "Pass-W0rd"
        fill_in :master_password_confirmation, with: "Pass-W0rd"
        click_on "アカウント登録"
        is_expected.to have_content "reCAPTCHA認証に失敗しました"
      end
    end
    xcontext 'success' do
      example 'fill in all' do
        fill_in :master_name,                  with: 'テスト太郎'
        fill_in :master_email,                 with: 'test@mail.com'
        fill_in :master_password,              with: 'Pass-W0rd'
        fill_in :master_password_confirmation, with: 'Pass-W0rd'
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
        visit new_master_session_path
      end
      context 'Failure' do
        example 'no name' do
          fill_in :master_name,    with: ''
          fill_in :master_email,    with: master.email
          fill_in :master_password, with: master.password
          click_button 'ログイン'
          is_expected.to have_content 'お名前、Emailまたはパスワードが違います。'
          # is_expected.to have_content "reCAPTCHA認証に失敗しました"
        end
        example 'no email' do
          fill_in :master_name,    with: master.name
          fill_in :master_email,    with: ''
          fill_in :master_password, with: master.password
          click_button 'ログイン'
          is_expected.to have_content 'お名前、Emailまたはパスワードが違います。'
          # is_expected.to have_content "reCAPTCHA認証に失敗しました"
        end
        example 'no password' do
          fill_in :master_name,    with: master.name
          fill_in :master_email,    with: master.email
          fill_in :master_password, with: ''
          click_button 'ログイン'
          is_expected.to have_content 'お名前、Emailまたはパスワードが違います。'
          # is_expected.to have_content "reCAPTCHA認証に失敗しました"
        end
        context 'recaptcha' do
          example 'no check' do
            fill_in :master_name,    with: master.name
            fill_in :master_email,    with: master.email
            fill_in :master_password, with: master.password
            click_button 'ログイン'
            is_expected.to have_content "reCAPTCHA認証に失敗しました"
          end
        end
        xexample 'not confirme' do
          master = FactoryBot.create(:fourth_master)
          master.confirmed_at = nil
          fill_in :master_email,    with: master.email
          fill_in :master_password, with: master.password
          click_button 'ログイン'
          is_expected.to have_content 'メールアドレスの本人確認が必要です'
        end
      end
      xcontext 'success' do
        example '' do
          fill_in :master_name,    with: master.name
          fill_in :master_email,    with: master.email
          fill_in :master_password, with: master.password
          # check '.recaptcha-checkbox-border'
          click_button 'ログイン'
          is_expected.to have_content 'ログインしました'
          is_expected.to have_content "マスターメニュー"
        end
      end
    end
    describe 'sign_out' do
      before do
        sign_in master
        visit master_path(master)
      end
      it {
        click_link 'ログアウト'
        is_expected.to have_content 'ログアウトしました'
        is_expected.to have_content 'このアプリを通して実現したいビジョンは'
      }
    end
  end


  describe 'edit' do
    subject { page }
    before do
      sign_in master
      visit master_path(master)
      click_link 'アカウント編集'
    end
    context 'Failure' do
      example 'no current_password' do
        fill_in 'お名前',             with: "名前変え太郎"
        fill_in 'Email',            with: "edited@mail.com"
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
        fill_in 'Email',            with: "edited@mail.com"
        fill_in 'パスワード',         with: "newPass-W0rd"
        fill_in 'パスワード（確認用）', with: "newPass-W0rd"
        fill_in '現在のパスワード',    with: master.password
        click_on "更新"
        is_expected.to have_content "アカウント情報を変更しました。"
      end
    end
  end
  describe 'destroy' do
    subject { page }
    before do
      sign_in master
      visit master_path(master)
      click_link 'マスター一覧'
    end
    context 'master account is one' do
      it 'master_validation' do
        is_expected.not_to have_content "削除"
      end
    end
    context 'master account are multiple' do
      before do
        master_2 = FactoryBot.create(:second_master)
        visit current_path
      end
      example 'confirm cancel' do
        page.dismiss_confirm("削除しますか？") do
          click_on '削除', match: :first
        end
        is_expected.not_to have_content "削除しました"
      end
      example 'confirm ok' do
        page.accept_confirm("削除しますか？") do
          click_on '削除', match: :first
        end
        is_expected.to have_content "削除しました"
      end
    end
  end


  let!(:hospital_label_1) { FactoryBot.create(:hospital_label, id: 1) }
  let!(:hospital_label_2) { FactoryBot.create(:second_hospital_label, id: 2) }

  describe 'new hospital' do
    subject { page }
    before do
      sign_in master
      visit master_path(master)
      click_link '新規病院'
    end
    context 'Failure' do
      example 'no name' do
        fill_in '病院名',        with: ''
        fill_in 'メールアドレス', with: 'test_hospital@mail.com'
        fill_in '電話番号',      with: '0123456789'
        fill_in '住所',         with: 'テスト県サンプル市123'
        check 'hospital_hospital_label_ids_1'
        click_on '登録'
        is_expected.to  have_content '病院名を入力してください'
      end
      example 'no email' do
        fill_in '病院名',        with: 'テスト病院'
        fill_in 'メールアドレス', with: ''
        fill_in '電話番号',      with: '0123456789'
        fill_in '住所',         with: 'テスト県サンプル市123'
        check 'hospital_hospital_label_ids_1'
        click_on '登録'
        is_expected.to  have_content 'メールアドレスを入力してください'
      end
      example 'no tel' do
        fill_in '病院名',        with: 'テスト病院'
        fill_in 'メールアドレス', with: 'test_hospital@mail.com'
        fill_in '電話番号',      with: ''
        fill_in '住所',         with: 'テスト県サンプル市123'
        check 'hospital_hospital_label_ids_1'
        click_on '登録'
        is_expected.to  have_content '電話番号を入力してください'
      end
      example 'no adress' do
        fill_in '病院名',        with: 'テスト病院'
        fill_in 'メールアドレス', with: 'test_hospital@mail.com'
        fill_in '電話番号',      with: '0123456789'
        fill_in '住所',         with: ''
        check 'hospital_hospital_label_ids_1'
        click_on '登録'
        is_expected.to  have_content '住所を入力してください'
      end
    end
    context 'success' do
      example 'full_in all' do
        fill_in '病院名',        with: 'テスト病院'
        fill_in 'メールアドレス', with: 'test_hospital@mail.com'
        fill_in '電話番号',      with: '0123456789'
        fill_in '住所',         with: 'テスト県サンプル市123'
        check 'hospital_hospital_label_ids_1'
        click_on '登録'
        is_expected.to  have_content '新規登録しました！'
      end
    end
  end


  describe 'hospital_label' do
    subject { page }
    before do
      sign_in master
      visit master_path(master)
      click_link '診療科一覧'
    end
    describe 'new' do
      before do
        click_on '新規診療科'
      end
      context 'Failure' do
        example 'no name' do
          fill_in '名前:', with: ''
          click_on '登録'
          is_expected.to have_content '名前を入力してください'
        end
      end
      context 'success' do
        example 'name ok' do
          fill_in '名前:', with: 'テスト科'
          click_on '登録'
          is_expected.to have_content '新規登録しました！'
        end
      end
    end
    describe 'edit' do
      before do
        click_on '編集', match: :first
      end
      it {
          fill_in '名前:', with: '変更名前科'
          click_on '更新'
          is_expected.to have_content '更新しました！'
      }
    end
  end


  let!(:hospital_1) { FactoryBot.create(:hospital, hospital_label_ids: [1]) }

  describe 'saport admin' do
    subject { page }
    before do
      sign_in master
      visit hospitals_path
      first('tbody tr td').click_link
    end
    context 'have button' do
      it {
        is_expected.to have_content '編集'
        is_expected.to have_content '削除'
      }
    end
  end
end

# Started POST "/masters/sign_in" for ::1 at 2022-11-13 15:58:25 +0900
# Processing by Devise::SessionsController#create as HTML
#   Parameters: {"authenticity_token"=>"3AfkCUb37Y5zVFEttU5Ra4EgLpk/kasXMS814hEceAPddPb2h6Mt5p+YN98cEZtskTRd0CU0GgwSeYLtuFjZfw==", "master"=>{"name"=>"", "email"=>"", "password"=>"[FILTERED]"}, "g-recaptcha-response"=>"", "commit"=>"ログイン"}
# Completed 401 Unauthorized in 11ms (ActiveRecord: 0.0ms | Allocations: 822)


# Processing by Devise::SessionsController#new as HTML
#   Parameters: {"authenticity_token"=>"3AfkCUb37Y5zVFEttU5Ra4EgLpk/kasXMS814hEceAPddPb2h6Mt5p+YN98cEZtskTRd0CU0GgwSeYLtuFjZfw==", "master"=>{"name"=>"", "email"=>"", "password"=>"[FILTERED]"}, "g-recaptcha-response"=>"", "commit"=>"ログイン"}
#   Rendering masters/sessions/new.html.erb within layouts/application
#   Rendered masters/sessions/new.html.erb within layouts/application (Duration: 25.6ms | Allocations: 661)
# [Webpacker] Everything's up-to-date. Nothing to do
#   Rendered layouts/_global_navi.html.erb (Duration: 10.5ms | Allocations: 530)

# Completed 200 OK in 174ms (Views: 159.7ms | ActiveRecord: 0.0ms | Allocations: 5668)


# Started POST "/patients/sign_in" for ::1 at 2022-11-13 15:29:58 +0900
# Processing by Patients::SessionsController#create as HTML
#   Parameters: {"authenticity_token"=>"a60zBDbvz6DdPaqLhePJWARPUdaf+FMbTbUiqLuSh8Zq3iH797sPyDHxzHksvANfFFsin4Vd4gBu45WnEtYmug==", "patient"=>{"email"=>"", "password"=>"[FILTERED]", "remember_me"=>"0"}, "g-recaptcha-response"=>"", "commit"=>"ログイン"}
#   Rendering patients/sessions/new.html.erb within layouts/application
#   Rendered patients/shared/_links.html.erb (Duration: 0.2ms | Allocations: 289)
#   Rendered patients/sessions/new.html.erb within layouts/application (Duration: 1.5ms | Allocations: 1550)
# [Webpacker] Everything's up-to-date. Nothing to do
#   Rendered layouts/_global_navi.html.erb (Duration: 0.5ms | Allocations: 571)
# Filter chain halted as :check_captcha_sign_in rendered or redirected
# Completed 200 OK in 12ms (Views: 7.1ms | ActiveRecord: 0.0ms | Allocations: 8806)