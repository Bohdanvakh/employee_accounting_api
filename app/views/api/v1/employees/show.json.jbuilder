json.employee do
  json.id @employee.id
  json.first_name @employee.first_name
  json.last_name @employee.last_name
end

json.vacations @vacations
json.total_vacation_days @total_vacation_days
json.salary @salary

json.position_histories @position_histories do |position_history|
  json.id position_history.id
  json.started_on position_history.started_on
  json.finished_on position_history.finished_on
end

json.last_position @last_position
