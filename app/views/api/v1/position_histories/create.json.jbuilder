json.position_history do
  json.extract! @position_history, :id, :position_id, :employee_id, :started_on, :finished_on
end
