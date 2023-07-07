json.extract! @department, :id, :name

json.employees @department.employees do |employee|
  json.extract! employee, :id, :first_name, :last_name
end

json.current_manager @current_manager do |manager|
  json.extract! manager, :first_name, :last_name
end
