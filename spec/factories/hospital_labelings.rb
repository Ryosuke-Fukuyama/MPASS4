FactoryBot.define do
  factory :hospital_labeling do
    association :hospital, factory: :hospital
    association :hospital_label, factory: :hospital_label
  end
end
