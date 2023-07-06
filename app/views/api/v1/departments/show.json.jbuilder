json.extract! @department, :id, :name

json.employees @department.employees do |employee|
  json.extract! employee, :id, :first_name, :last_name
end

json.current_manager @current_manager do |manager|
  json.first_name manager.first_name
  json.last_name manager.last_name
end
