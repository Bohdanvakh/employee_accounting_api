require 'swagger_helper'

RSpec.describe 'position_histories', type: :request do

  path '/employees/{id}/position_histories' do
    post 'create position_history' do
      tags 'Position_histories'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :position_history, in: :body, schema: {
        type: :object,
        properties: {
          started_on: { type: :string, format: 'date' },
          finished_on: { type: :string, format: 'date' },
          employee_id: { type: :integer },
          position_id: { type: :integer }
        },
        required: ['started_on', 'employee_id', 'position_id']
      }

      response '200', 'successful' do
        let(:employee) { Employee.create(last_name: 'Lorem', first_name: 'Ipsum', middle_name: 'Dolor', passport_data: '111151234', date_of_birth: '2001-01-01', place_of_birth: 'Lviv Ukraine', home_address: '123 Lviv Ukraine', department_id: 3) }
        let(:position) { FactoryBot.create(name: "Lorem ipsum", salary: 1000, vacation_days: 30) }
        let(:position_history) { PositionHistory.create(employee_id: employee.id, position_id: position.id, started_on: "2023-07-03", finished_on: nil) }
        run_test!
      end
    end
  end

  path '/employees/{id}/position_histories/{id}' do
    put 'update position_history' do
      tags 'Position_histories'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          position_history: {
            type: :object,
            properties: {
              started_on: { type: :string, format: 'date' },
              finished_on: { type: :string, format: 'date' },
              employee_id: { type: :integer },
              position_id: { type: :integer }
            },
            required: ['started_on', 'employee_id', 'position_id']
          }
        },
        required: ['position_history']
      }

      produces 'application/json'

      response '200', 'successful' do
        let(:params) { { position_history: attributes_for(:position_history) } }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
