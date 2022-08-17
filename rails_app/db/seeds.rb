# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Patient.create!(name: "sample_user",
#                 email: "sample@mail.com",
#                 password: "passw0r-D",
#                 confirmed_at: Time.now
#                )

# Hospital.create!(name:    "テスト病院",
#                  email:   Faker::Internet.unique.email,
#                  tel:     sprintf('%10d', rand(9999999999)),
#                  address: Gimei.address.kanji,
# )

Staff.create!(name:        "sample_staff",
              password:    "passw0r-D",
              hospital_id: 1
)


# 10.times do |n|
#   name =         Gimei.name.kanji
#   email =        Faker::Internet.unique.email
#   password =     "password0"
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

# email =        Faker::Internet.unique.email
# tel =          sprintf('%10d', rand(9999999999))
# address =      Gimei.address.kanji
# access =       "〇〇駅 徒歩◆◆分"
# introduction = Faker::Internet.url
# # image =        open("./public/images/sample.jpg")
# [
#   ["テスト用総合病院", email, tel, address, access, introduction, open("./public/images/test.jpg"), [1, 2, 3, 4, 5]],
#   ["サンプルクリニック", email, tel, address, access, introduction, image, [1]],
#   ["サンプル医院", email, tel, address, access, introduction, image, [1]],
#   ["サンプル眼科", email, tel, address, access, introduction, image, [6]],
#   ["サンプル耳鼻科", email, tel, address, access, introduction, image, [7]],
#   ["サンプル小児科", email, tel, address, access, introduction, image, [1, 8]],
#   ["サンプル歯科", email, tel, address, access, introduction, image, [9]],
#   ["サンプル歯科クリニック", email, tel, address, access, introduction, image, [9]],
#   ["サンプル接骨院", email, tel, address, access, introduction, image, []],
#   ["サンプル休日診療所", email, tel, address, access, introduction, image, []],
#   ["DICクリニック", email, tel, "東京都渋谷区円山町28番4号大場ビルA館", access, introduction, image, []]
# ].each do |name, email, tel, address, access, introduction, image, hospital_label_ids|
#   Hospital.create!({
#     name: name,
#     email: email,
#     tel: tel,
#     address: address,
#     access: access,
#     introduction: introduction,
#     # image: image,
#     # hospital_label_ids: hospital_label_ids
#   })
# end

# 10.times do |n|
#   name =     Gimei.unique.name.last.kanji
#   password = "password0"

#   Staff.create!(
#     name:        name,
#     password:    password,
#     hospital_id: 1
#   )
# end

# Patient.eager_load(:health_interviews).all.each do |p|
#   age =            "#{1 + rand(100)}"
#   gender =         HealthInterview.genders.keys.sample
#   symptomatology = "症状(サンプル)"
#   condition =      "持病等(サンプル)"


  # HealthInterview.create!(
  #   age:            age,
  #   gender:         gender,
  #   symptomatology: symptomatology,
  #   condition:      condition,
  #   patient_id:     p.id,
  #   hospital_id:    1
  # )
# end

# HealthInterview.eager_load(:guide_label).all.each do |h_i|
#   GuideLabel.create!(health_interview_id: h_i.id)
# end

# Master.create!(password: "password0")