json.position_history do
  json.id @position_history.id
  json.position_id @position_history.position_id
  json.employee_id @position_history.employee_id
  json.started_on @position_history.started_on
  json.finished_on @position_history.finished_on
end
