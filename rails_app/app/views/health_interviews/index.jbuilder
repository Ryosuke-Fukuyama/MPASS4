json.health_interviews @health_interviews_0 do |health_interview_0|
  json.extract! health_interview, :id, :content, :created_at
  json.guide_status health_interview.guide_status, :id, :status
end
json.health_interviews @health_interviews_1 do |health_interview_1|
  json.extract! health_interview, :id, :content, :created_at
  json.guide_status health_interview.guide_status, :id, :status
end
json.health_interviews @health_interviews_3 do |health_interview_3|
  json.extract! health_interview, :id, :content, :created_at
  json.guide_status health_interview.guide_status, :id, :status
end