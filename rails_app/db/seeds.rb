# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

# # Examples:

# #   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# #   Character.create(name: 'Luke', movie: movies.first)

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

# [
#   ["サンプルクリニック", [1]],
#   ["医院", [1]],
#   ["眼科", [6]],
#   ["耳鼻科", [7]],
#   ["小児科", [1, 8]],
#   ["歯科", [9]],
#   ["歯科クリニック", [9]],
#   ["接骨院", []],
#   ["休日診療所", []],
#   ["DIC総合病院", [1, 2, 3, 4, 5]]
# ].each do |name, hospital_label_ids|
#   Hospital.create!({
#     name:               Gimei.last.kanji + name,
#     email:              Faker::Internet.unique.email,
#     tel:                sprintf('%10d', rand(9999999999)), #　Faker::PhoneNumber.unique.cell_phone # ハイフン有
#     address:            Gimei.address.kanji,
#     access:             "〇〇駅 徒歩◆◆分",
#     introduction:       "http://sample-url",
#     # image:            open("./public/images/sample.jpg"),
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
#   symptomatology = "(サンプル)３日前から発熱、倦怠感と吐き気"
#   condition =      "(サンプル)持病等"

#   HealthInterview.create!(
#     age:            "#{1 + rand(100)}",
#     gender:         0,
#     symptomatology: symptomatology,
#     condition:      condition,
#     patient_id:     p.id,
#     hospital_id:    1
#   )
# end

# HealthInterview.eager_load(:guide_status).all.each do |h_i|
#   GuideStatus.create!(health_interview_id: h_i.id)
# end

# # Rspec用
# Master.create!(
#   name:         "デモマスター",
#   email:        "demo_master@mail.com",
#   password:     "passw0r-D",
#   confirmed_at: Time.now
# )

# Patient.create!(
#   name:         "デモ患者",
#   email:        "demo_patient@mail.com",
#   password:     "passw0r-D",
#   confirmed_at: Time.now
# )

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