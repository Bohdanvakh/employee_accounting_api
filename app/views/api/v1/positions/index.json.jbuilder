json.array! @positions do |position|
  json.extract! position, :id, :name, :salary, :vacation_days
end
