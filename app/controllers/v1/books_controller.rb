module V1
    class BooksController < ApplicationController
        before_action :find_book, only: [:show, :edit, :update, :destroy]
        skip_before_action :authorize_request, only: [:index, :show] 
        
        resource_description do
            formats [:json]
        end

        def_param_group :book do
            param :book, Hash, :required => true do
                param :title, String, desc: 'Title of book', :required => true
                param :genre, String, desc: 'Genre of book', :required => true
                param :year, Integer, desc: 'Year of publication of the book', :required => true
                param :plot, String, desc: 'Short plot descripition', :required => true
                param :author_id, Integer, desc: 'Id of author', :required => true
            end
        end

        # GET v1/books
        api :GET, '/v1/books', "Show all books"
        param_group :book
        def index
            @books = Book.all      
            json_response(@books)  
        end

        # GET v1/books/:id
        api :GET, '/v1/books/:id', "Show specific book"
        param_group :book
        def show    
            json_response(@book)    
        end

        # POST v1/books
        api :POST, '/v1/books/', "Create a book"
        param_group :book
        def create
            @book = Book.create!(book_params)
            @book.save
            json_response(@book, :created)  
        end

        # PATCH v1/books/:id
        api :PATCH, '/v1/books/:id', "Update specific book"
        param_group :book
        def update
            @book.update(book_params)
            head :no_content
        end 

        # DELETE v1/books/:id
        api :DELETE, '/v1/books/:id', "Delete specific book"
        param_group :book
        def destroy
            @book.destroy
            head :no_content
        end

        private

        def book_params
            params.permit(:title, :genre, :year, :plot, :author_id)
        end

        def find_book
            @book = Book.find(params[:id])
        end
    end
end

