password = "passw0r-D"

10.times do |n|
  # email =   Faker::Internet.unique.email

  Patient.create!(
    name:                  Gimei.name.kanji,
    email:                 Faker::Internet.unique.email,
    password:              password,
    password_confirmation: password,
    confirmed_at:          Time.now
  )
end

[
  "内科",      # 1
  "外科",      # 2
  "整形外科",   # 3
  "皮膚科",    # 4
  "脳神経外科", # 5
  "眼科",      # 6
  "耳鼻科",    # 7
  "小児科",    # 8
  "歯科",      # 9
  "接骨院"     # 10
].each do |name|
    HospitalLabel.create!(name: name)
end

[
  ["サンプルクリニック", [1]],
  ["DIC総合病院", [1, 2, 3, 4, 5]],
  ["眼科", [6]],
  ["耳鼻科", [7]],
  ["小児科", [1, 8]],
  ["歯科", [9]],
  ["歯科クリニック", [9]],
  ["接骨院", [10]],
  ["休日診療所", [1]],
  ["医院", [1]], ["医院", [1]], ["医院", [1]], ["医院", [1]], ["医院", [1]], ["医院", [1]], ["医院", [1]], ["医院", [1]], ["医院", [1]], ["医院", [1]], ["医院", [1]], ["医院", [1]]
].each do |name, hospital_label_ids|
  Hospital.create!({
    name:               Gimei.last.kanji + name,
    email:              Faker::Internet.unique.email,
    tel:                sprintf('%10d', rand(9999999999)), #　Faker::PhoneNumber.unique.cell_phone # ハイフン有
    address:            Gimei.address.kanji,
    access:             "〇〇駅 徒歩◆◆分",
    introduction:       "http://sample-url",
    # image:            open("./public/images/sample.jpg"),
    hospital_label_ids: hospital_label_ids
  })
end

20.times do |n|
  Staff.create!(
    name:                  Gimei.unique.name.kanji,
    password:              password,
    password_confirmation: password,
    hospital_id:           1
  )
end

Patient.eager_load(:health_interviews).all.each do |p|
  symptoms =  '(サンプル)３日前から発熱、倦怠感と吐き気'
  condition = '(サンプル)持病等'

  HealthInterview.create!(
    age:         "#{1 + rand(100)}",
    gender:      0,
    condition:   condition,
    symptoms:    symptoms,
    patient_id:  p.id,
    hospital_id: 2
  )
end
Patient.eager_load(:health_interviews).all.each do |p|
  symptoms =  '(サンプル)３日前から発熱、倦怠感と吐き気'
  condition = '(サンプル)持病等'

  HealthInterview.create!(
    age:         "#{1 + rand(100)}",
    gender:      0,
    condition:   condition,
    symptoms:    symptoms,
    patient_id:  p.id,
    hospital_id: 1
  )
end

# 周回すると一つのHealthInterviewに複数のGuideStatusが付いてバグる。
HealthInterview.eager_load(:guide_status).where(health_interviews: { hospital_id: 2 }).all.each do |h|
  GuideStatus.create!(
    status:             'complete',
    health_interview_id: h.id
  )
end
HealthInterview.eager_load(:guide_status).where(health_interviews: { hospital_id: 1 }).all.each do |h|
  GuideStatus.create!(health_interview_id: h.id)
end

Master.create!(
  name:                  "テストマスター",
  email:                 "t_master@mail.com",
  password:              password,
  password_confirmation: password,
  confirmed_at:          Time.now
)

Patient.create!(
  name:                  "テスト患者",
  email:                 "t_patient@mail.com",
  password:              password,
  password_confirmation: password,
  confirmed_at:          Time.now
)

Staff.create!(
  name:                  "テストスタッフ",
  password:              password,
  password_confirmation: password,
  admin:                 "false",
  hospital_id:           1
)

Staff.create!(
  name:                  "テストアドミン",
  password:              password,
  password_confirmation: password,
  admin:                 "true",
  hospital_id:           1
)
