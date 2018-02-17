require 'rails_helper'

RSpec.describe 'Authors', type: :request do
  # initialize test data 
  let(:user) { create(:user) }
  let!(:authors) { create_list(:author, 10) }
  let(:author_id) { authors.first.id }
  # authorize request
  let(:headers) { valid_headers }

  # Test suite for GET /authors
  describe 'GET /authors' do
    before { get '/authors', params: {}, headers: headers }

    it 'returns authors' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end  
  end

  # Test suite for GET /authors/:id
  describe 'GET /authors/:id' do
    before { get "/authors/#{author_id}", params: {}, headers: headers  }

    context 'when the record exists' do
      it 'returns the author' do
        expect(json).not_to be_empty
        expect(json['author']['id']).to eq(author_id)
        expect(json['books'].count).to eq(authors[author_id].books.count)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      context 'when the record does not exist' do
        let(:author_id) { 100 }
  
        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end
  
        it 'returns a not found message' do
          expect(response.body).to match(/Couldn't find Author/)
        end
      end
    end
  end


  # Test suite for POST /authors
  describe 'POST /authors' do
    # valid payload
    let(:valid_attributes)do
      { author: { first_name: 'Freddie', last_name: 'Mercury', bio: 'Some bio'} }.to_json
    end

    context 'when the request is valid' do
      before { post '/authors', params: valid_attributes, headers: headers }

      it 'creates a author' do
        expect(json['first_name']).to eq('Freddie')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) do
        { author:{first_name: 'Freddie', last_name: 'Mercury'}}.to_json
      end

      before { post '/authors', params: invalid_attributes, headers: headers}

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['message'])
          .to match(/Validation failed: Bio can't be blank/)
      end
    end
  end


  # Test suite for patch /authors/:id
  describe 'PATCH /authors/:id' do
    let(:valid_attributes) {{ author:{ first_name: 'Roger', last_name: 'Taylor'} }.to_json}

    context 'when the record exists' do
      before { patch "/authors/#{author_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /authors/:id
  describe 'DELETE /authors/:id' do
    before { delete "/authors/#{author_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end