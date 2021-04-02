require 'rails_helper'

describe InterventionsController do
    context 'GET /ajax/GetData' do
        it 'returns ok, and as JSON' do
            # Method in Intervention controller being tested
            get :getData

            # Expecting a good response to the GET request
            expect(response.status).to eq(200)

            # Expecting the return type to be JSON
            expect(response.content_type).to eq("application/json")

        end
    end
end