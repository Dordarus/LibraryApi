class AuthorsController < ApplicationController
  before_action :find_author, only: [:show, :update, :destroy]
  #before_action :signed_in_user, only: [:new, :create, :edit, :update, :destroy]

	# GET /authors
  def index
	  @authors = Author.all
	  json_response(@authors)
	end
	
  # GET /author/:id
  def show
	  json_response({author: @author, books: @author.books.all})
  end    

	# PUT /author/:id
  def update      
	  @author.update(author_params)
	  json_response(@author)
  end

	# POST /autors
  def create
	  @author = Author.create!(author_params)
	  @author.save
	  json_response(@author)
  end   

	private 
	
  def author_params
	  params.require(:author).permit(:first_name, :last_name, :bio)
  end

  def find_author
	  @author = Author.find(params[:id])
  end
end
