json.vacation do
  json.extract! @vacation, :id, :started_on, :finished_on, :employee_id
end
