FactoryBot.define do
  factory :staff do
    name { 'スタッフ1' }
    admin { false }
    # password { 'Pass-W0rd' }
    # password_confirmation { 'Pass-W0rd' }
    # association :hospital, factory: :hospital
  end
  factory :second_staff, class: 'Staff' do
    name { 'スタッフ2' }
    admin { false }
    # password { 'Pass-W0rd' }
    # password_confirmation { 'Pass-W0rd' }
    # association :hospital, factory: :hospital
  end
  factory :admin_staff, class: 'Staff' do
    name { 'スタッフ3' }
    admin { true }
    # password { 'Pass-W0rd' }
    # password_confirmation { 'Pass-W0rd' }
    # association :hospital, factory: :hospital
  end
end
