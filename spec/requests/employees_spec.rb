require 'swagger_helper'

RSpec.describe 'employees', type: :request do

  path '/employees' do
    get 'List employees' do
      tags 'Employees'
      response(200, 'successful') do
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

    post 'create employee' do
      tags 'Employees'
      consumes 'application/json', 'application/xml'
      produces 'application/json'
      parameter name: :employee, in: :body, schema: {
        type: :object,
        properties: {
          last_name: { type: :string },
          first_name: { type: :string },
          middle_name: { type: :string },
          passport_data: { type: :string },
          date_of_birth: { type: :string, format: 'date' },
          place_of_birth: { type: :string },
          home_address: { type: :string },
          home_address: { type: :string },
          department_id: { type: :integer }
        },
        required: [ 'last_name', 'first_name', 'middle_name', 'passport_data', 'date_of_birth', 'place_of_birth', 'home_address', 'department_id' ]
      }

      response '201', 'employee created' do
        let(:employee) { { last_name: 'Lorem', first_name: 'Ipsum', middle_name: 'Dolor', passport_data:'123456789', date_of_birth: "2001-01-01", place_of_birth: 'New York, US', home_address: '555 Middle Street', department_id: 1 } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:employee) { { last_name: '', first_name: '', middle_name: '', passport_data:'', date_of_birth: '', place_of_birth: '', home_address: '', department_id: nil } }
        run_test!
      end
    end
  end

  path '/employees/{id}' do
    get 'Retrieves an employee' do
      tags 'Employees'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      request_body_example value: { some_field: 'Lorem' }, name: 'basic', summary: 'Request example description'

      response '200', 'successful' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            last_name: { type: :string },
            first_name: { type: :string },
            middle_name: { type: :string },
            passport_data: { type: :string },
            date_of_birth: { type: :string, format: 'date' },
            place_of_birth: { type: :string },
            home_address: { type: :string },
            home_address: { type: :string },
            department_id: { type: :integer }
          },
          required: [ 'last_name', 'first_name', 'middle_name', 'passport_data', 'date_of_birth', 'place_of_birth', 'home_address', 'department_id' ]

        let(:id) { Employee.create(last_name: 'Lorem', first_name: 'Ipsum', middle_name: 'Dolor', passport_data: '987651234', date_of_birth: '2001-01-01', place_of_birth: 'Lviv Ukraine', home_address: '123 Lviv Ukraine', department_id: 3).id }
        run_test!
      end
    end

    put 'update employee' do
      tags 'Employees'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          employee: {
            type: :object,
            properties: {
              last_name: { type: :string },
              first_name: { type: :string },
              middle_name: { type: :string },
              passport_data: { type: :string },
              date_of_birth: { type: :string, format: 'date' },
              place_of_birth: { type: :string },
              home_address: { type: :string },
              home_address: { type: :string },
              department_id: { type: :integer }
            },
            required: ['last_name', 'first_name', 'middle_name', 'passport_data', 'date_of_birth', 'place_of_birth', 'home_address', 'department_id']
          }
        },
        required: ['employee']
      }

      produces 'application/json'


      response '200', 'successful' do
        let(:params) { { employee: attributes_for(:employee) } }

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

    delete 'delete employee' do
      tags 'Employees'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'successful' do
        let(:id) { create(:employee).id }
        run_test!
      end
    end
  end
end
