FactoryBot.define do
  factory :hospital do
    name { '第一病院' }
    email { 'hospital-1@mail.com' }
    tel { 0000000001 }
    address { '1丁目' }
    access { 'バス1分' }
    # image { open('./public/images/sample.jpg') }
    introduction { 'url: https://hospital-1' }
  end
  factory :second_hospital, class: 'Hospital' do
    name { '第二病院' }
    email { 'hospital-2@mail.com' }
    tel { 0000000002 }
    address { '2丁目' }
    access { 'バス2分' }
    # image { open('./public/images/test.jpg') }
    introduction { 'url: https://hospital-2' }
  end
  factory :third_hospital, class: 'Hospital' do
    name { '第三病院' }
    email { 'hospital-3@mail.com' }
    tel { 0000000003 }
    address { '3丁目' }
    access { 'バス3分' }
    # image { open('./public/images/test.jpg') }
    introduction { 'url: https://hospital-3' }
  end
end
