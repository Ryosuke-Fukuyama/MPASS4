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
        is_expected.to have_content 'お名前を入力してください'
      end
      example 'no email' do
        fill_in :master_name,                  with: 'テスト太郎'
        fill_in :master_email,                 with: ''
        fill_in :master_password,              with: 'Pass-W0rd'
        fill_in :master_password_confirmation, with: 'Pass-W0rd'
        click_on 'アカウント登録'
        is_expected.to have_content 'Eメールを入力してください'
      end
      example 'no password' do
        fill_in :master_name,                  with: 'テスト太郎'
        fill_in :master_email,                 with: 'test@mail.com'
        fill_in :master_password,              with: ''
        fill_in :master_password_confirmation, with: 'Pass-W0rd'
        click_on 'アカウント登録'
        is_expected.to have_content 'パスワードを入力してください'
      end
      example 'not_eq password' do
        fill_in :master_name,                  with: 'テスト太郎'
        fill_in :master_email,                 with: 'test@mail.com'
        fill_in :master_password,              with: 'Pass-W0rd'
        fill_in :master_password_confirmation, with: 'Pass-W01234'
        click_on 'アカウント登録'
        is_expected.to have_content 'パスワード（確認用）とパスワードの入力が一致しません'
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
          is_expected.to have_content 'Eメールまたはパスワードが違います'
        end
        example 'no email' do
          fill_in :master_name,    with: master.name
          fill_in :master_email,    with: ''
          fill_in :master_password, with: master.password
          click_button 'ログイン'
          is_expected.to have_content 'Eメールまたはパスワードが違います'
        end
        example 'no password' do
          fill_in :master_name,    with: master.name
          fill_in :master_email,    with: master.email
          fill_in :master_password, with: ''
          click_button 'ログイン'
          is_expected.to have_content 'Eメールまたはパスワードが違います'
        end
        # example 'not confirme' do
        #   master = FactoryBot.create(:fourth_master)
        #   master.confirmed_at = nil
        #   fill_in :master_email,    with: master.email
        #   fill_in :master_password, with: master.password
        #   click_button 'ログイン'
        #   is_expected.to have_content 'メールアドレスの本人確認が必要です'
        # end
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


  # describe 'edit' do
  #   subject { page }
  #   before do
  #     sign_in master
  #     visit master_path(master)
  #     click_link 'アカウント編集'
  #   end
  #   context 'Failure' do
  #     example 'no current_password' do
  #       fill_in :master_name,             with: "名前変え太郎"
  #       fill_in :master_email,            with: "edited@mail.com"
  #       fill_in :master_password,         with: "newPass-W0rd"
  #       fill_in :master_password_confirmation, with: "newPass-W0rd"
  #       fill_in '現在のmaster_password',    with: ""
  #       click_on "更新"
  #       is_expected.to have_content "現在のパスワードを入力してください"
  #     end
  #   end
  #   context 'success' do
  #     example 'ok current_password' do
  #       fill_in :master_name,             with: "名前変え太郎"
  #       fill_in :master_email,            with: "edited@mail.com"
  #       fill_in :master_password,         with: "newPass-W0rd"
  #       fill_in :master_password_confirmation, with: "newPass-W0rd"
  #       fill_in '現在のmaster_password',    with: master.password
  #       click_on "更新"
  #       is_expected.to have_content "アカウント情報を変更しました。"
  #     end
  #   end
  #   context 'account delete' do
  #     example 'confirm cancel' do
  #       page.dismiss_confirm("本当によろしいですか？") do
  #         click_on 'アカウント削除'
  #       end
  #     end
  #     example 'confirm ok' do
  #       page.accept_confirm("本当によろしいですか？") do
  #         click_on 'アカウント削除'
  #       end
  #       is_expected.to have_content "アカウントを削除しました。"
  #       is_expected.to have_content 'このアプリを通して実現したいビジョンは'
  #     end
  #   end
  # end
end
