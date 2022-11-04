FactoryBot.define do
  factory :master do
    name                  { 'マスター1号' }
    email                 { 'master-1@mail.com' }
    password              { 'Pass-W0rd' }
    password_confirmation { 'Pass-W0rd' }
    confirmed_at          { Time.now }
  end
  # factory :second_master, class: 'Master' do
  #   name                  { 'マスター2号' }
  #   email                 { 'master-2@mail.com' }
  #   password              { 'Pass-W0rd' }
  #   password_confirmation { 'Pass-W0rd' }
  #   confirmed_at          {  }
  # end
end
