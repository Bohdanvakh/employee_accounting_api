json.employee do
  json.extract! @employee, :id, :first_name, :last_name
end

json.vacations @vacations
json.total_vacation_days @total_vacation_days
json.salary @salary

json.position_histories @position_histories do |position_history|
  json.extract! position_history, :id, :started_on, :finished_on
end

json.last_position @last_position
