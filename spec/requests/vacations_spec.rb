require 'swagger_helper'

RSpec.describe 'vacations', type: :request do
  path '/employees/{id}/vacations' do
    post 'Creates a vacation' do
      tags 'Vacations'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :vacation, in: :body, schema: {
        type: :object,
        properties: {
          started_on: { type: :string, format: 'date' },
          finished_on: { type: :string, format: 'date' },
          employee_id: { type: :integer }
        },
        required: ['started_on', 'finished_on', 'employee_id']
      }

      response '201', 'vacation created' do
        let(:employee) { Employee.create(last_name: 'Lorem', first_name: 'Ipsum', middle_name: 'Dolor', passport_data: '111151234', date_of_birth: '2001-01-01', place_of_birth: 'Lviv Ukraine', home_address: '123 Lviv Ukraine', department_id: 3) }
        let(:position) { FactoryBot.create(name: "Lorem ipsum", salary: 1000, vacation_days: 30) }
        let(:position_history) { PositionHistory.create(employee_id: employee.id, position_id: position.id, started_on: "2023-01-01", finished_on: nil) }
        let(:vacation) { { started_on: '2023-07-01', finished_on: '2023-07-05', employee_id: employee.id } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:employee) { Employee.create(last_name: 'Lorem', first_name: 'Ipsum', middle_name: 'Dolor', passport_data: '111151234', date_of_birth: '2001-01-01', place_of_birth: 'Lviv Ukraine', home_address: '123 Lviv Ukraine', department_id: 3) }
        let(:vacation) { { started_on: '2023-07-01', finished_on: nil, employee_id: employee.id } }
        run_test!
      end
    end
  end
end
