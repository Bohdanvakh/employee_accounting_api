require 'swagger_helper'

RSpec.describe 'departments', type: :request do

  path '/departments' do
    get 'List departments' do
      tags 'Departments'
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

    post 'Create department' do
      tags 'Departments'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :department, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          abbreviation: { type: :string }
        },
        required: ['name', 'abbreviation']
      }

      response '201', 'Department created' do
        let(:department) { { name: 'Department Name', abbreviation: 'Dept' } }
        run_test!
      end

      response '422', 'Invalid request' do
        let(:department) { { name: '', abbreviation: '' } }
        run_test!
      end
    end
  end

  path '/departments/{id}' do
    get 'Retrieves a department' do
      tags 'Departments'
      produces 'application/json', 'application/xml'
      parameter name: :id, in: :path, type: :string
      request_body_example value: { some_field: 'Lorem' }, name: 'basic', summary: 'Request example description'

      response '200', 'Department found' do
        schema type: :object,
          properties: {
            id: { type: :integer, },
            name: { type: :string },
            abbreviation: { type: :string }
          },
          required: [ 'id', 'name', 'abbreviation' ]

        let(:id) { Department.create(name: 'Department Name', abbreviation: 'Lorem ipsum dolor sit amet, consectetuer').id }
        run_test!
      end

      response '404', 'department not found' do
        let(:id) { 'invalid' }
        run_test!
      end

      response '406', 'unsupported accept header' do
        let(:'Accept') { 'departments/lorem' }
        run_test!
      end
    end

    put 'update department' do
      tags 'Departments'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          department: {
            type: :object,
            properties: {
              name: { type: :string },
              abbreviation: { type: :string },
            },
            required: ['name', 'abbreviation']
          }
        },
        required: ['department']
      }

      produces 'application/json'

      response '201', 'department updated successful' do
        let(:params) { { department: attributes_for(:department) } }

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

    delete 'delete department' do
      tags 'Departments'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      produces 'application/json'

      response '200', 'successful' do
        let(:id) { create(:department).id }
        run_test!
      end
    end
  end
end
