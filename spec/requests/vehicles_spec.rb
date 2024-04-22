require "swagger_helper"

RSpec.describe "Vehicles", type: :request do
  let!(:resource) { create(:vehicle, :toyota) }

  after do |example|
    if response.body.present?
      example.metadata[:response][:content] = {
        "application/json" => {
          example: JSON.parse(response.body)
        }
      }
    end
  end

  path "/api/vehicles/{id}" do
    get("get vehicle details by id") do
      consumes "application/json"
      produces "application/json"

      parameter name: :id, in: :path, type: :string
      response(200, :ok) do
        schema "$ref" => "swagger/v1/schemas/vehicles.json#/definitions/show_body"

        let(:id) { resource.id.join("_") }
        run_test!
      end
    end

    put("update vehicle msrp") do
      consumes "application/json"
      produces "application/json"

      parameter name: :id, in: :path, type: :string
      parameter name: :body_params, in: :body, schema: {
        "$ref" => "swagger/v1/schemas/vehicles.json#/definitions/put_body"
      }

      response(204, :no_content) do
        let(:body_params) { { vehicle: { msrp: 102_456_00 } } }
        let(:id) { resource.id.join("_") }

        run_test! do
          expect(resource.reload.msrp)
            .to eq(102_456_00)
        end
      end
    end
  end
end
