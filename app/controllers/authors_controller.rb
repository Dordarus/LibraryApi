class AuthorsController < ApplicationController
	before_action :find_author, only: [:show, :update, :destroy]
	skip_before_action :authorize_request, only: [:index, :show] 
  
	# GET /authors
  def index
	  @authors = Author.all
	  json_response(@authors)
	end
	
  # GET /author/:id
  def show
	  json_response({author: @author, books: @author.books.all})
  end    

	# PATCH /author/:id
  def update      
	  @author.update(author_params)
	  head :no_content
  end

	# POST /autors
  def create
	  @author = Author.create!(author_params)
	  @author.save
	  json_response(@author, :created)
  end   

	# DELETE /books/:id
  def destroy
		@author.destroy
		head :no_content
	end

	private 
	
  def author_params
	  params.require(:author).permit(:first_name, :last_name, :bio)
  end

  def find_author
	  @author = Author.find(params[:id])
  end
end
