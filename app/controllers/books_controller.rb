class BooksController < ApplicationController
  before_action :find_book, only: [:show, :edit, :update, :destroy]
  #before_action :signed_in_user, only: [:new, :create, :edit, :update, :destroy]
  
  # GET /books
  def index
      @books = Book.all      
      json_response(@books)  
  end

  # GET /books/:id
  def show    
      json_response(@book)    
  end

  # POST /books
  def create
      @book = Book.create!(book_params)
      @book.save
      json_response(@book, :created)  
  end

  # PATCH /books/:id
  def update
      @book.update(book_params)
      head :no_content
  end 

  # DELETE /books/:id
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
