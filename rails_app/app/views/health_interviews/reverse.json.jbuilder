json.health_interviews_3 @health_interviews_3 do |health_interview|
  json.extract! health_interview, :id, :hospital_id
  json.guide_status health_interview.guide_status, :id, :status
end
json.health_interviews_4 @health_interviews_4 do |health_interview|
  json.extract! health_interview, :id, :hospital_id
  json.guide_status health_interview.guide_status, :id, :status
end
json.session_check @session_check
