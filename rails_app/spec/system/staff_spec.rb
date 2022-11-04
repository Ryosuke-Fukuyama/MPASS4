require 'rails_helper'
RSpec.describe 'staff', type: :system do
  let!(:hospital) { FactoryBot.create(:hospital) }
  let!(:hospital_2) { FactoryBot.create(:second_hospital) }
  let!(:staff) { FactoryBot.create(:staff, hospital_id: hospital.id) }
  let!(:staff_2) { FactoryBot.create(:second_staff, hospital_id: hospital.id) }
  let!(:admin_staff) { FactoryBot.create(:admin_staff, hospital_id: hospital.id) }

  let!(:patient_2) { FactoryBot.create(:second_patient) }
  let!(:health_interview_2) { FactoryBot.create(:health_interview, patient: patient_2, hospital_id: hospital.id) }
  let!(:guide_label_2) { FactoryBot.create(:guide_label, health_interview: health_interview_2) }

  let!(:patient_3) { FactoryBot.create(:third_patient) }
  let!(:health_interview_3) { FactoryBot.create(:health_interview, patient: patient_3, hospital_id: hospital.id) }
  let!(:guide_label_3) { FactoryBot.create(:guide_label, health_interview: health_interview_3) }

  let!(:patient_4) { FactoryBot.create(:fourth_patient) }
  let!(:health_interview_4) { FactoryBot.create(:health_interview, patient: patient_4, hospital_id: hospital.id) }
  let!(:guide_label_4) { FactoryBot.create(:guide_label, health_interview: health_interview_4) }

  # before do
  #   visit new_staff_session_path
  # end

  # describe 'session' do
  #   before do
  #     visit new_staff_session_path
  #   end
  #   describe 'sign_in' do
  #     context 'Failure' do
  #       example 'no name' do
  #         fill_in :staff_name,     with: ''
  #         fill_in :staff_password, with: staff.password
  #         click_on 'スタッフログイン'
  #         expect(page).to have_content 'IDまたはパスワードが違います'
  #       end

  #       example 'no password' do
  #         fill_in :staff_name,     with: staff.name
  #         fill_in :staff_password, with: ''
  #         click_on 'スタッフログイン'
  #         expect(page).to have_content 'IDまたはパスワードが違います'
  #       end
  #     end

  #     context 'success ->transition In-house_index' do
  #       example 'all ok' do
  #         fill_in :staff_name,     with: staff.name
  #         fill_in :staff_password, with: staff.password
  #         click_on 'スタッフログイン'
  #         expect(page).to have_content 'ログインしました'
  #         expect(current_path).to have_content "/hospitals/#{staff.hospital_id}/health_interviews"
  #       end
  #     end
  #   end

  #   describe 'sign_out' do
  #     context 'success ->transition new_session' do
  #       example 'only_case' do
  #         fill_in :staff_name, with: staff.name
  #         fill_in :staff_password, with: staff.password
  #         click_on 'スタッフログイン'
  #         click_on 'ログアウト'
  #         expect(page).to have_content 'ログアウトしました'
  #         expect(current_path).to have_content '/staffs/sign_in'
  #       end
  #     end
  #   end
  # end

#   # describe 'status' do
#   #   before do
#   #     fill_in :staff_name, with: staff.name
#   #     fill_in :staff_password, with: staff.password
#   #     click_on 'スタッフログイン'
#   #   end
#   #   context 'update' do
#   #     example 'Ajax' do
#   #       first("option[value='calling']").select_option
#   #       @list_top = first('.list_of_healthinterviews')
#   #       expect(@list_top).to have_content health_interview_2.id
#   #       first("option[value='pending']").select_option
#   #       @list_bottom = last('.list_of_healthinterviews')
#   #       expect(@list_bottom).to have_content health_interview_2.id
#   #     end
#   #   end
#   # end

  # describe 'admin_page' do
  #   before do
  #     visit new_staff_session_path
  #     fill_in :staff_name, with: admin_staff.name
  #     fill_in :staff_password, with: admin_staff.password
  #     click_on 'スタッフログイン'
  #   end

    # describe 'patients' do
    #   subject { page }

    #   before do
    #     click_on '患者一覧'
        @list_top =
    #   end

    #   it { is_expected.to have_content '来院回数' }
        context 'sort created_at_asc' do
          subject { @list_top }
          it { is_expected.to have_content .name }
        end
    #   context 'search' do
    #     example 'success' do
    #       fill_in :q_name_cont, with: patient_2.name
    #       click_on '検索する'
    #       expect(page).to have_content patient_2.name
    #       expect(page).not_to have_content patient_4.name
    #     end
    #   end

    #   context 'transition show' do
    #     example 'success' do
    #       find("#patient-#{patient_4.id}-healthinterviews-history").click
    #       expect(page).to have_content "#{patient_4.name}来院履歴"
    #     end
    #   end

    #   context 'account delete' do
    #     example 'confirm cancel' do
    #       page.dismiss_confirm('削除しますか？') do
    #         click_on '削除', match: :first
    #       end
    #       expect(page).to have_content patient_2.name
    #     end

    #     example 'confirm ok' do
    #       page.accept_confirm('削除しますか？') do
    #         click_on '削除', match: :first
    #       end
    #       expect(page).to have_content '削除しました'
    #       expect(page).not_to have_content patient_2.name
    #     end
    #   end
    # end

    describe 'staffs' do
      subject { page }

      before do
        click_on 'スタッフ一覧'
        @list_top =
      end

      it { is_expected.to have_content '管理権限' }
        context 'sort created_at_asc' do
          subject { @list_top }
          it { is_expected.to have_content  }
        end
  #     context 'search' do
  #       example 'success' do
  #         fill_in :q_name_cont, with: staff_2.name
  #         click_on '検索する'
  #         expect(page).to have_content staff_2.name
  #         expect(page).not_to have_content staff.name
  #       end
  #     end

  #     describe 'create_staff' do
  #       subject { current_path }

  #       before do
  #         click_on 'スタッフ新規作成'
  #       end

  #       it { is_expected.to have_content '/staffs/new' }

  #       context 'Failure' do
  #         example 'no name' do
  #           fill_in :staff_name,                  with: ''
  #           fill_in :staff_password,              with: 'pass1234'
  #           fill_in :staff_password_confirmation, with: 'pass1234'
  #           click_on '登録する'
  #           expect(page).to have_content 'IDを入力してください'
  #         end

  #         example 'no password' do
  #           fill_in :staff_name,                  with: 'test_staff'
  #           fill_in :staff_password,              with: ''
  #           fill_in :staff_password_confirmation, with: 'pass1234'
  #           click_on '登録する'
  #           expect(page).to have_content 'パスワードを入力してください'
  #         end

  #         example 'not eq password' do
  #           fill_in :staff_name,                  with: 'test_staff'
  #           fill_in :staff_password,              with: 'pass1234'
  #           fill_in :staff_password_confirmation, with: 'pass9876'
  #           click_on '登録する'
  #           expect(page).to have_content 'パスワード（確認用）とパスワードの入力が一致しません'
  #         end
  #       end

  #       context 'success' do
  #         example 'all ok' do
  #           fill_in :staff_name,                  with: 'test_staff'
  #           fill_in :staff_password,              with: 'pass1234'
  #           fill_in :staff_password_confirmation, with: 'pass1234'
  #           click_on '登録する'
  #           expect(page).to have_content '登録しました'
  #           expect(page).to have_content 'test_staff'
  #         end
  #       end
  #     end

  #     describe 'edit_staff' do
  #       subject { current_path }

  #       before do
  #         find("#in-house-edit-staff-#{staff.id}").click
  #       end

  #       it { is_expected.to have_content "/staffs/#{staff.id}/edit" }

  #       context 'update' do
  #         example 'Failure' do
  #           fill_in :staff_name,                  with: ''
  #           fill_in :staff_password,              with: 'pass1234'
  #           fill_in :staff_password_confirmation, with: 'pass1234'
  #           check('staff_admin')
  #           click_on '更新する'
  #           expect(page).to have_content 'IDを入力してください'
  #         end
  #         example 'success' do
  #           fill_in :staff_name,                  with: 'edit_staff'
  #           fill_in :staff_password,              with: 'pass1234'
  #           fill_in :staff_password_confirmation, with: 'pass1234'
  #           check('staff_admin')
  #           click_on '更新する'
  #           expect(page).to have_content '更新しました'
  #           expect(page).to have_content 'edit_staff'
  #           # expect(staff.admin).to eq 'true'
  #         end
  #       end

  #       context 'account delete' do
  #         example 'confirm cancel' do
  #           page.dismiss_confirm('削除しますか？') do
  #             find("#in-house-delete-staff-#{staff.id}").click
  #           end
  #           expect(page).to have_content staff.name
  #         end

  #         example 'confirm ok' do
  #           page.accept_confirm('削除しますか？') do
  #             find("#in-house-delete-staff-#{staff.id}").click
  #           end
  #           expect(page).to have_content 'スタッフを削除しました'
  #           expect(page).not_to have_content staff.name
  #         end
  #       end
  #     end
  #   end
  end

  describe 'not admin' do
    before do
      visit new_staff_session_path
      fill_in :staff_name, with: staff.name
      fill_in :staff_password, with: staff.password
      click_on 'スタッフログイン'
    end
    context 'redirect' do
      example '' do
      end

      example '' do
      end

      example '' do
      end

      example '' do
      end

      example '' do
      end
    end
  end
end
