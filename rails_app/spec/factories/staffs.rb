FactoryBot.define do
  factory :staff do
    name { 'スタッフA' }
    password { 'Pass-W0rd' }
    password_confirmation { 'Pass-W0rd' }
    admin { false }
    # association :hospital, factory: :hospital
  end
  factory :second_staff, class: 'Staff' do
    name { 'スタッフB' }
    password { 'Pass-W0rd' }
    password_confirmation { 'Pass-W0rd' }
    admin { false }
    # association :hospital, factory: :hospital
  end
  factory :admin_staff, class: 'Staff' do
    name { 'アドミンスタッフ' }
    password { 'Pass-W0rd' }
    password_confirmation { 'Pass-W0rd' }
    admin { true }
    # association :hospital, factory: :hospital
  end
end
