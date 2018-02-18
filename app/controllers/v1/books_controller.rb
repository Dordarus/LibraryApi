module V1
    class BooksController < ApplicationController
    before_action :find_book, only: [:show, :edit, :update, :destroy]
    skip_before_action :authorize_request, only: [:index, :show] 
    
    def_param_group :author do
      param :author, Hash do
        param :first_name, String, "First name of the author"
        param :last_name, String, "Last name of the author"
        param :bio, String, "Short biography of the author"
      end
    end
      
      def_param_group :book do
        param :book, Hash do
          param :title, String, "Title of the book"
          param :genre, String, "Genre of the book"
          param :year, Integer, "Year of book publishing"
          param :plot, String, "Short description of the book's plot"
          param_group :author
        end
      end

    # GET /books
    param_group :book
    def index
        @books = Book.all      
        json_response(@books)  
    end

    # GET /books/:id
    param_group :book
    def show    
        json_response(@book)    
    end

    # POST /books
    param_group :book
    def create
        @book = Book.create!(book_params)
        @book.save
        json_response(@book, :created)  
    end

    # PATCH /books/:id
    param_group :book
    def update
        @book.update(book_params)
        head :no_content
    end 

    # DELETE /books/:id
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
