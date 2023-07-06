json.vacation do
  json.id @vacation.id
  json.started_on @vacation.started_on
  json.finished_on @vacation.finished_on
  json.employee_id @vacation.employee_id
end
