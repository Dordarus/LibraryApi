module V1
	class AuthorsController < ApplicationController
		before_action :find_author, only: [:show, :update, :destroy]
		skip_before_action :authorize_request, only: [:index, :show] 
		
		def_param_group :author do
            param :author, Hash do
				param :first_name, String, desc: 'First name of author', :required => true
				param :last_name, String, desc: 'Last name of author', :required => true
				param :bio, String, desc: 'Short biography of author', :required => true
				param :books, Array, of: Book, desc: "List of author's book" do
					param :book, Hash, desc: "Author's book"  do
						param :title, String, desc: 'Title of book', :required => true
						param :genre, String, desc: 'Genre of book', :required => true
						param :year, Integer, desc: 'Year of publication of the book', :required => true
						param :plot, String, desc: 'Short plot descripition', :required => true
					end
				end
			end
		end

		def_param_group :authentication do
			param "Authorization: Basic <base64 encoded values>", String, :desc => "Login requires standard HTTP Basic Authentication header", :required => true
		end
		
		# GET v1/authors
		api :GET, '/v1/authors', "Show all authors"
		param_group :author
		description <<-EOS 
			###Example cURL
			 curl http://localhost:3000/v1/authors
		EOS

		def index
			@authors = Author.all
			json_response(@authors)
		end
		
		# GET v1/authors/:id
		api :GET, '/v1/authors/:id', "Show specific author with books"
		param_group :author
		description <<-EOS 
			###Example cURL
			 curl http://localhost:3000/v1/authors/1
		EOS
		def show
			json_response({author: @author, books: @author.books.all})
		end    

		# PATCH v1/authors/:id
		api :PATCH, '/v1/authors/:id', "Update specific author"
		param_group :authentication
		param_group :author
		description <<-EOS
			###Example cURL
			 curl -X PATCH \\ 
			 -H 'Authorization: [auth_token]' \\
			 -d 'author[key]=[value]' \\
			 http://localhost:3000/v1/authors/1
		EOS
		def update      
			@author.update(author_params)
			head :no_content
		end

		# POST v1/autors
		api :POST, '/v1/authors/', "Create a author"
		param_group :authentication
		param_group :author
		description <<-EOS
			###Example cURL
			 curl -X POST \\ 
			 -H 'Authorization: [auth_token]' \\
			 -d 'author[first_name]=[value]' \\
			 -d 'author[last_name]=[value]' \\
			 -d 'author[bio]=[value]' \\
			 http://localhost:3000/v1/authors
		EOS
		def create
			@author = Author.create!(author_params)
			@author.save
			json_response(@author, :created)
		end   

		# DELETE v1/authors/:id
		api :DELETE, '/v1/authors/:id', "Delete specific author"
		param_group :authentication
		param_group :author
		description <<-EOS
			###Example cURL
			 curl -X DELETE \\ 
			 -H 'Authorization: [auth_token]' \\
			 http://localhost:3000/v1/authors/1
		EOS
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
end
