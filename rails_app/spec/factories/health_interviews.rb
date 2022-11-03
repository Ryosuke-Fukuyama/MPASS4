FactoryBot.define do
  factory :health_interview do
    symptomatology { 'MyText' }
    condition { 'MyText' }
    comment { 'MyText' }
    patient { nil }
  end
end
