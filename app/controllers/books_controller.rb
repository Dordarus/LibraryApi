class BooksController < ApplicationController
  before_action :find_book, only: [:show, :edit, :update, :destroy]
  skip_before_action :authorize_request, only: [:index, :show] 
  
  resource_description do
    formats [:json]
  end

  def_param_group :book do
    param :book, Hash, :action_aware => true do
      param :title, String, desc: 'Title of book'
      param :genre, String, desc: 'Genre of book'
      param :year, Integer, desc: 'Year of publication of the book'
      param :plot, String, desc: 'Short plot descripition'
      param_group :author
    end
  end

  def_param_group :author do
    param :author, Hash, :action_aware => true do
      param :first_name, String, desc: 'First name of author'
      param :last_name, String, desc: 'Last name of author'
      param :bio, String, desc: 'Short biography of author'
    end
  end

  # GET /books
  api :GET, '/books', "Show all books"
  param_group :book
  def index
      @books = Book.all      
      json_response(@books)  
  end

  # GET /books/:id
  api :GET, '/books/:id', "Show specific book"
  param_group :book
  def show    
      json_response(@book)    
  end

  # POST /books
  api :POST, '/books/', "Create a book"
  param_group :book

  def create
      @book = Book.create!(book_params)
      @book.save
      json_response(@book, :created)  
  end

  # PATCH /books/:id
  api :PATCH, '/books/:id', "Update specific book"
  param_group :book
  def update
      @book.update(book_params)
      head :no_content
  end 

  # DELETE /books/:id
  api :DELETE, '/books/:id', "Delete specific book"
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
