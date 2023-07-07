json.array! @departments do |department|
  json.extract! department, :id, :name
  json.employees_number department.employees.count
end

