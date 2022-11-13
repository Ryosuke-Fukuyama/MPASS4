require 'rails_helper'
RSpec.describe 'staff', type: :system do
  let!(:hospital_label_1) { FactoryBot.create(:hospital_label, id: 1) }
  let!(:hospital_label_2) { FactoryBot.create(:second_hospital_label, id: 2) }
  let!(:hospital_1) { FactoryBot.create(:hospital, hospital_label_ids: [1]) }
  let!(:staff_1) { FactoryBot.create(:staff, hospital_id: hospital_1.id) }
  let!(:staff_2) { FactoryBot.create(:second_staff, hospital_id: hospital_1.id) }
  let!(:admin_staff) { FactoryBot.create(:admin_staff, hospital_id: hospital_1.id) }
  # let!(:hospital_2) { FactoryBot.create(:second_hospital) }

  let!(:patient_1) { FactoryBot.create(:patient, id: 1) }
  let!(:health_interview_1) { FactoryBot.create(:health_interview, id: 1, patient: patient_1, hospital_id: hospital_1.id) }
  let!(:guide_status_1) { FactoryBot.create(:guide_status, status: "payment", id: 1, health_interview_id: health_interview_1.id) }

  let!(:patient_2) { FactoryBot.create(:second_patient, name: "あ太郎") }
  let!(:health_interview_2) { FactoryBot.create(:second_health_interview, patient: patient_2, hospital_id: hospital_1.id) }
  let!(:guide_status_2) { FactoryBot.create(:guide_status, health_interview_id: health_interview_2.id) }

  let!(:patient_3) { FactoryBot.create(:third_patient) }
  let!(:health_interview_3) { FactoryBot.create(:third_health_interview, patient: patient_3, hospital_id: hospital_1.id) }
  let!(:guide_status_3) { FactoryBot.create(:guide_status, health_interview_id: health_interview_3.id) }

  let!(:delete_verify_env_test){ Recaptcha.configuration.skip_verify_env.delete("test") }

  describe 'session' do
    subject { page }
    before do
      visit new_staff_session_path
    end
    describe 'sign_in' do
      context 'Failure' do
        example 'no name' do
          fill_in 'ID',       with: ''
          fill_in 'パスワード', with: staff_1.password
          click_on 'スタッフログイン'
          # is_expected.to have_content 'IDまたはパスワードが違います'
          is_expected.not_to have_content 'マスターメニュー'
        end
        example 'no password' do
          fill_in 'ID',       with: staff_1.name
          fill_in 'パスワード', with: ''
          click_on 'スタッフログイン'
          # is_expected.to have_content 'IDまたはパスワードが違います'
          is_expected.not_to have_content 'マスターメニュー'
        end
      end
      xcontext 'success' do
        example 'all ok' do
          fill_in 'ID',       with: staff_1.name
          fill_in 'パスワード', with: staff_1.password
          # check '.recaptcha-checkbox-border'
          click_on 'スタッフログイン'
          is_expected.to have_content 'ログインしました'
          expect(current_path).to have_content "/hospitals/#{staff_1.hospital_id}/health_interviews"
        end
      end
    end
    describe 'sign_out' do
      it {
        sign_in staff_1
        visit health_interviews_path(staff_1.hospital_id)
        click_on 'ログアウト'
        is_expected.to have_content 'ログアウトしました'
        expect(current_path).to have_content '/staffs/sign_in'
      }
    end
  end


  describe 'status' do
    before do
      sign_in staff_1
      visit health_interviews_path(staff_1.hospital_id)
    end
    context 'update' do
      describe 'index' do
        xexample 'status change' do
          select '呼出', from: first('select')
          expect('#calling__list ').to have_content health_interview_2.guide_status.id
          # expect{ select '呼出', from: first('select') }.to change{ first('select') }.from('初期').to('呼出')

          select '保留', from: first('select')
          expect('#pending__list ').to have_content health_interview_2.guide_status.id
        end
      end
      describe 'reverse' do
        before do
          click_link '裏面'
        end
        xexample 'status change' do
          select '無断キャンセル', from: first('select')
          expect('#noshow__list ').to have_content health_interview_1.guide_status.id
        end
        xexample 'payment' do
          # id_num = health_interview_1.guide_status.id
          # click_link "#{id_num}"
          visit health_interview_path(staff_1.hospital_id, 1)
          click_link '編集'
          fill_in 'health_interview_price', with: 1000 # 入らない
          page.accept_confirm('ステータスの値は正しいですか？') do
            click_on '更新'
            # find('#submit').click # 押せない
          end
          is_expected.to have_content '更新しました'
          is_expected.to have_content '¥1000'
        end
      end
    end
  end


  describe 'admin' do
    before do
      sign_in admin_staff
      visit hospital_path(admin_staff.hospital_id)
    end
    describe 'patients' do
      subject { page }
      before do
        click_on '患者一覧'
      end
      context 'sort name asc' do
        it {
            expect(first('tbody tr')).to have_content patient_2.name
          }
      end
      context 'search' do
        example 'name' do
          fill_in '名前', with: patient_3.name
          click_on '検索'
          is_expected.to have_content patient_3.name
          is_expected.not_to have_content patient_1.name
        end
      end
      context 'show' do
        it {
          find("#patient-#{patient_1.id}-healthinterviews-history").click
          is_expected.to have_content "来院履歴"
        }
      end
      context 'account delete' do
        example 'confirm cancel' do
          page.dismiss_confirm('削除しますか？') do
            click_on '削除', match: :first
          end
          is_expected.to have_content patient_1.name
        end
        example 'confirm ok' do
          page.accept_confirm('削除しますか？') do
            click_on '削除', match: :first
          end
          is_expected.to have_content '削除しました'
          is_expected.not_to have_content patient_2.name
        end
      end
    end


    describe 'staffs' do
      subject { page }
      before do
        click_on 'スタッフ一覧'
      end
      context 'sort name asc' do
        it {
          expect(first('tbody tr')).to have_content admin_staff.name
        }
      end
      context 'search' do
        example 'name' do
          fill_in '名前', with: staff_1.name
          click_on '検索'
          is_expected.to have_content staff_1.name
          is_expected.not_to have_content admin_staff.name
        end
        example 'admin' do
          check '管理権限'
          click_on '検索'
          is_expected.to have_content admin_staff.name
          is_expected.not_to have_content staff_1.name
        end
      end
      describe 'create_staff' do
        before do
          click_on 'スタッフ新規作成'
        end
        context 'Failure' do
          example 'no name' do
            fill_in 'ID',                with: ''
            fill_in 'パスワード',         with: 'pass-W0rd'
            fill_in 'パスワード（確認用）', with: 'pass-W0rd'
            click_on '登録'
            is_expected.to have_content 'IDを入力してください'
          end
          example 'no password' do
            fill_in 'ID',                with: 'テストスタッフ'
            fill_in 'パスワード',         with: ''
            fill_in 'パスワード（確認用）', with: 'pass-W0rd'
            click_on '登録'
            is_expected.to have_content 'パスワードを入力してください'
          end
          example 'not eq password' do
            fill_in 'ID',                with: 'テストスタッフ'
            fill_in 'パスワード',         with: 'pass-W0rd'
            fill_in 'パスワード（確認用）', with: 'passw0r-D'
            click_on '登録'
            is_expected.to have_content 'パスワード（確認用）とパスワードの入力が一致しません'
          end
        end
        context 'success' do
          example 'all ok' do
            fill_in 'ID',                with: 'テストスタッフ'
            fill_in 'パスワード',         with: 'pass-W0rd'
            fill_in 'パスワード（確認用）', with: 'pass-W0rd'
            click_on '登録'
            is_expected.to have_content '登録しました'
            is_expected.to have_content 'テストスタッフ'
          end
        end
      end
      describe 'edit_staff' do
        context 'update' do
          xexample 'success' do
            find("#in-house-edit-staff-#{staff_1.id}").click
            fill_in 'ID',               with: 'ボブ'
            fill_in 'パスワード',         with: 'new_pass-W0rd'
            fill_in 'パスワード（確認用）', with: 'new_pass-W0rd'
            # click_on '更新'
            find('#submit').click # 押せない
            is_expected.to have_content '更新しました'
            is_expected.to have_content 'ボブ'
          end
        end
      end
      describe 'destroy' do
        xcontext 'self admin no btn' do
          it { is_expected.not_to have_content find("#in-house-delete-staff-#{admin_staff.id}") }
        end
        context 'not admin' do
          example 'confirm cancel' do
            page.dismiss_confirm('削除しますか？') do
              find("#in-house-delete-staff-#{staff_1.id}").click
            end
            is_expected.to have_content staff_1.name
          end
          xexample 'confirm ok' do
            page.accept_confirm('削除しますか？') do
              find("#in-house-delete-staff-#{staff_1.id}").click
            end
            is_expected.to have_content '削除しました'
            is_expected.not_to have_content staff_1.name
          end
        end
      end
    end


    describe 'this hospital' do
      subject { page }
      context 'edit' do
        example 'name changed' do
          click_link '編集'
          fill_in '病院名',        with: '改名病院'
          # fill_in 'メールアドレス', with: ''
          # fill_in '電話番号',      with: ''
          # fill_in '住所',         with: ''
          check 'hospital_hospital_label_ids_2'
          click_on '更新'
          is_expected.to have_content '更新しました！'
          is_expected.to have_content '改名病院'
        end
      end
      context 'destroy' do
        example 'confirm cancel' do
          page.dismiss_confirm('削除しますか？') do
            click_link '削除'
          end
          is_expected.to have_content hospital_1.name
        end
        example 'confirm ok' do
          page.accept_confirm('削除しますか？') do
            click_link '削除'
          end
          is_expected.to have_content '削除しました'
          is_expected.to have_content '病院名'
        end
      end
    end
  end


  describe 'not admin' do
    subject { page }
    before do
      sign_in staff_1
    end
    context 'redirect' do
      example '患者一覧開けない' do
        visit patients_path(staff_1.hospital_id)
        is_expected.not_to have_content '患者一覧'
      end
      example 'スタッフ一覧開けない' do
        visit staffs_path(staff_1.hospital_id)
        is_expected.not_to have_content 'スタッフ一覧'
      end
      before do
        visit hospital_path(staff_1.hospital_id)
      end
      context 'no button' do
        it { is_expected.not_to have_content '編集' }
        it { is_expected.not_to have_content '削除' }
      end
    end
  end
end