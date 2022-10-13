json.health_interviews @health_interviews do |health_interview|
  json.extract! health_interview, :id, :content, :created_at
  json.guide_status health_interview.guide_status, :id, :status
end
