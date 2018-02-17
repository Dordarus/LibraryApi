# spec/requests/books_spec.rb
require 'rails_helper'

RSpec.describe 'Books' do
  # Initialize the test data
  let(:user) { create(:user) }
  let!(:author) { create(:author) }
  let(:author_id) { author.id }
  let!(:books) { create_list(:book, 5, author_id: author_id) }
  let(:id) { books.first.id }
  let(:headers) { valid_headers }

  # Test suite for GET /books
  describe 'GET /books' do
    before { get "/books", params: {}, headers: headers }

    it 'returns status code 200' do
			expect(response).to have_http_status(200)
    end

    it 'returns all books' do
			expect(json.size).to eq(5)
    end
  end

  # Test suite for GET /books/:id
  describe 'GET /books/:id' do
    before { get "/books/#{id}", params: {}, headers: headers }

    context 'when book exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the book' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when book does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Book/)
      end
    end
  end

  # Test suite for POST /books
  describe 'POST /books' do
    let(:valid_attributes) { { title: "Title", genre: "some genre", year: 1234, plot:"some plot", author_id: author_id }.to_json }

    context 'when request attributes are valid' do
      before { post "/books", params: valid_attributes, headers: headers }
			
      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/books", params: { genre: "some genre", year: 1234, plot:"some plot", author_id: author_id }.to_json, headers: headers}

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Title can't be blank/)
      end
    end
  end

  # Test suite for PATCH /books/:id
  describe 'PATCH /books/:id' do
    let(:valid_attributes) { { title: "Mozart's life" }.to_json}

    before { patch "/books/#{id}", params: valid_attributes, headers: headers }

    context 'when book exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the book' do
        updated_book = Book.find(id)
        expect(updated_book.title).to match(/Mozart's life/)
      end
    end

    context 'when the book does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Book/)
      end
    end
  end

  # Test suite for DELETE /books/:id
  describe 'DELETE /books/:id' do
    before { delete "/books/#{id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end