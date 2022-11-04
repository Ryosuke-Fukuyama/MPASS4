FactoryBot.define do
  factory :health_interview do
    age { '11' }
    gender { 'man' }
    symptomatology { '症状-1' }
    condition { '持病-1' }
    # association :patient, factory: :patient
    # association :hospital, factory: :hospital
  end
  factory :second_health_interview, class: 'HealthInterview' do
    age { '22' }
    gender { 'woman' }
    symptomatology { '症状-2' }
    condition { '持病-2' }
    # association :patient, factory: :patient
    # association :hospital, factory: :hospital
  end
  factory :third_health_interview, class: 'HealthInterview' do
    age { '33' }
    gender { 'man' }
    symptomatology { '症状-3' }
    condition { '持病-3' }
    # association :patient, factory: :patient
    # association :hospital, factory: :hospital
  end
end
