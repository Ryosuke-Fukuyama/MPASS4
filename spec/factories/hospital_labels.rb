FactoryBot.define do
  factory :hospital_label do
    name { '内科' }
  end
  factory :second_hospital_label, class: 'HospitalLabel' do
    name { '外科' }
  end
end
