# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

# Examples:

#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 10.times do |n|
#   name =         Gimei.name.kanji
#   email =        Faker::Internet.unique.email
#   password =     "passw0r-D"
#   confirmed_at = Time.now

#   Patient.create!(
#     name:         name,
#     email:        email,
#     password:     password,
#     confirmed_at: confirmed_at,
#   )
# end

# [
#   ["内科"],      # 1
#   ["外科"],      # 2
#   ["整形外科"],   # 3
#   ["皮膚科"],    # 4
#   ["脳神経外科"], # 5
#   ["眼科"],      # 6
#   ["耳鼻科"],    # 7
#   ["小児科"],    # 8
#   ["歯科"]       # 9
# ].each do |name|
#     HospitalLabel.create!(name: name)
# end

# name =         Gimei.last.kanji
# email =        Faker::Internet.unique.email
# tel =          Faker::PhoneNumber.unique.cell_phone
# address =      Gimei.address.kanji
# access =       "〇〇駅 徒歩◆◆分"
# introduction = "http://sample-url"
# image =        "" # open("./public/images/sample.jpg")
# [
#   ["サンプルクリニック", email, tel, address, access, introduction, image, [1]],
#   ["#{name}医院", email, tel, address, access, introduction, image, [1]],
#   ["#{name}眼科", email, tel, address, access, introduction, image, [6]],
#   ["#{name}耳鼻科", email, tel, address, access, introduction, image, [7]],
#   ["#{name}小児科", email, tel, address, access, introduction, image, [1, 8]],
#   ["#{name}歯科", email, tel, address, access, introduction, image, [9]],
#   ["#{name}歯科クリニック", email, tel, address, access, introduction, image, [9]],
#   ["#{name}接骨院", email, tel, address, access, introduction, image, []],
#   ["#{name}休日診療所", email, tel, address, access, introduction, image, []],
#   ["DIC総合病院", email, tel, addressaccess, introduction, image, [1, 2, 3, 4, 5]]
# ].each do |name, email, tel, address, access, introduction, image, hospital_label_ids|
#   Hospital.create!({
#     name: name,
#     email: email,
#     tel: tel,
#     address: address,
#     access: access,
#     introduction: introduction,
#     image: image,
#     hospital_label_ids: hospital_label_ids
#   })
# end

# 10.times do |n|
#   Staff.create!(
#     name:        Gimei.unique.name.kanji,
#     password:    "passw0r-D",
#     hospital_id: 1
#   )
# end

# Patient.eager_load(:health_interviews).all.each do |p|
#   age =            "#{1 + rand(100)}"
#   gender =         HealthInterview.genders.keys.sample
#   symptomatology = "症状(サンプル)"
#   condition =      "持病等(サンプル)"


#   HealthInterview.create!(
#     age:            age,
#     gender:         gender,
#     symptomatology: symptomatology,
#     condition:      condition,
#     patient_id:     p.id,
#     hospital_id:    1
#   )
# end

# HealthInterview.eager_load(:guide_status).all.each do |h_i|
#   GuideLabel.create!(health_interview_id: h_i.id)
# end

# # Rspec用
# Master.create!(
#   name:         "デモマスター",
#   email:        "demo_master@mail.com",
#   password:     "passw0r-D",
#   confirmed_at: Time.now
# )

Patient.create!(
  name:         "デモ患者",
  email:        "demo_patient@mail.com",
  password:     "passw0r-D",
  confirmed_at: Time.now
)

# Staff.create!(
#   name:         "デモスタッフ",
#   password:     "passw0r-D",
#   admin:        "false"
# )

# Staff.create!(
#   name:         "デモアドミン",
#   email:        "demo_staff@mail.com",
#   password:     "passw0r-D",
#   admin:        "true"
# )