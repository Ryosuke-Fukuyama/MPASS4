FactoryBot.define do
  factory :patient do
    name                  { '一郎' }
    email                 { 'patient-1@mail.com' }
    password              { 'Pass-W0rd' }
    password_confirmation { 'Pass-W0rd' }
    confirmed_at          { Time.now }
  end
  factory :second_patient, class: 'Patient' do
    name                  { '二郎' }
    email                 { 'patient-2@mail.com' }
    password              { 'Pass-W0rd' }
    password_confirmation { 'Pass-W0rd' }
    confirmed_at          { Time.now }
  end
  factory :third_patient, class: 'Patient' do
    name                  { '三郎' }
    email                 { 'patient-3@mail.com' }
    password              { 'Pass-W0rd' }
    password_confirmation { 'Pass-W0rd' }
    confirmed_at          { Time.now }
  end
  factory :fourth_patient, class: 'Patient' do
    name                  { 'とこ' }
    email                 { 'patient-4@mail.com' }
    password              { 'Pass-W0rd' }
    password_confirmation { 'Pass-W0rd' }
    confirmed_at          { Time.now }
  end
  factory :fifth_patient, class: 'Patient' do
    name                  { 'リゼ' }
    email                 { 'patient-5@mail.com' }
    password              { 'Pass-W0rd' }
    password_confirmation { 'Pass-W0rd' }
    confirmed_at          { Time.now }
  end
  factory :sixth_patient, class: 'Patient' do
    name                  { 'アンジュ' }
    email                 { 'patient-6@mail.com' }
    password              { 'Pass-W0rd' }
    password_confirmation { 'Pass-W0rd' }
    confirmed_at          { Time.now }
  end
end
