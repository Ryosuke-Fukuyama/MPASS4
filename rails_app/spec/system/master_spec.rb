require 'rails_helper'

RSpec.describe 'Master', type: :system do
  let!(:master) { FactoryBot.create(:master) }

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
      #  #  未実装
      # example 'no check' do
      #   fill_in :master_name,                  with: "テスト太郎"
      #   fill_in :master_email,                 with: "test@mail.com"
      #   fill_in :master_password,              with: "Pass-W0rd"
      #   fill_in :master_password_confirmation, with: "Pass-W0rd"
      #   click_on "アカウント登録"
      #   is_expected.to have_content "reCAPTCHA認証に失敗しました"
      # end
    end
    context 'success' do
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
          is_expected.to have_content 'Emailまたはパスワードが違います'
        end
        example 'no email' do
          fill_in :master_name,    with: master.name
          fill_in :master_email,    with: ''
          fill_in :master_password, with: master.password
          click_button 'ログイン'
          is_expected.to have_content 'Emailまたはパスワードが違います'
        end
        example 'no password' do
          fill_in :master_name,    with: master.name
          fill_in :master_email,    with: master.email
          fill_in :master_password, with: ''
          click_button 'ログイン'
          is_expected.to have_content 'Emailまたはパスワードが違います'
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
      context 'success' do
        example '' do
          fill_in :master_name,    with: master.name
          fill_in :master_email,    with: master.email
          fill_in :master_password, with: master.password
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
          first('button').click_link
        end
        is_expected.not_to have_content "削除しました"
      end
      example 'confirm ok' do
        page.accept_confirm("削除しますか？") do
          first('button').click_link
        end
        is_expected.to have_content "削除しました"
      end
    end
  end


  let!(:hospital_label_1) { FactoryBot.create(:hospital_label, id: 1) }
  let!(:hospital_label_2) { FactoryBot.create(:second_hospital_label) }

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
        first('tbody tr td button').click_on
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
