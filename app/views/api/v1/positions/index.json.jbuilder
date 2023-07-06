json.array! @positions do |position|
  json.id position.id
  json.name position.name
  json.salary position.salary
  json.vacation_days position.vacation_days
end
