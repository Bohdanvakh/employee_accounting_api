json.employee do
  json.extract! @employee, :id, :first_name, :last_name
end
