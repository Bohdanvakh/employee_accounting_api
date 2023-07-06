json.employees @department.employees do |employee|
  json.extract! employee, :id, :name, :email
end
