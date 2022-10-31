json.health_interviews_1 @health_interviews_1 do |health_interview|
  json.extract! health_interview, :id, :hospital_id
  json.guide_status health_interview.guide_status, :id, :status
end
json.health_interviews_0 @health_interviews_0 do |health_interview|
  json.extract! health_interview, :id, :hospital_id
  json.guide_status health_interview.guide_status, :id, :status
end
json.health_interviews_2 @health_interviews_2 do |health_interview|
  json.extract! health_interview, :id, :hospital_id
  json.guide_status health_interview.guide_status, :id, :status
end
