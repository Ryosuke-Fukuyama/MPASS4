FactoryBot.define do
  factory :favorite_hospital do
    association :patient, factory: :patient
    association :hospital, factory: :hospital
  end
end
