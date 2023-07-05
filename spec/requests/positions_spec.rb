require 'swagger_helper'

RSpec.describe 'positions', type: :request do
  path '/positions' do

    get 'list positions' do
      tags 'Positions'
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

    post 'create position' do
      tags 'Positions'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :position, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          salary: { type: :integer },
          vacation_days: { type: :integer },
        },
        required: ['name', 'salary', 'vacation_days']
      }

      response '201', 'Position created' do
        let(:position) { { name: 'Position Name', salary: 1000, vacation_days: 15 } }
        run_test!
      end
    end
  end

  path '/positions/{id}' do
    get 'Retrieves a position' do
      tags 'Positions'
      produces 'application/json', 'application/xml'
      parameter name: :id, in: :path, type: :string
      request_body_example value: { some_field: 'Lorem' }, name: 'basic', summary: 'Request example description'

      response '200', 'Position found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            salary: { type: :integer },
            vacation_days: { type: :integer }
          },
          required: [ 'id', 'name,' 'salary', 'vacation_days' ]

        let(:id) { Position.create(name: 'Position Name', salary: 1000, vacation_days: 20).id }
        run_test!
      end
    end

    put 'update position' do
      tags 'Positions'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          position: {
            type: :object,
            properties: {
              name: { type: :string },
              salary: { type: :integer },
              vacation_days: { type: :integer },
            },
            required: ['name', 'salary', 'vacation_days']
          }
        },
        required: ['position']
      }

      produces 'application/json'

      response '201', 'position updated successful' do
        let(:params) { { position: attributes_for(:position)} }

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

    delete 'delete position' do
      tags 'Positions'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      produces 'application/json'

      response '200', 'successful' do
        let(:id) { create(:position).id }
        run_test!
      end
    end
  end
end
