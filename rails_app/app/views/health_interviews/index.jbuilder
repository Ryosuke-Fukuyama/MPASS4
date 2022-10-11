json.properties @properties do |property|
  json.extract! property, :id, :content, :created_at
  json.label property.label, :id, :status
end
