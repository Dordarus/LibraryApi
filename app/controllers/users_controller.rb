class UsersController < ApplicationController
  skip_before_action :authorize_request, only: :create
    # POST /signup
    # return authenticated token upon signup
    api :POST, '/signup', "Create a user and return authenticated token upon signup"
    param :user, Hash, desc: 'User information' do
      param :name, String, desc: 'Full name of user', :required => true
      param :email, String, desc: 'Email nessessary for signup', :required => true
      param :password, String, desc: 'Password nessessary for signup', :required => true
      param :password_confirmation, String, desc: 'Password confirmnation', :required => true
    end
    def create
      user = User.create!(user_params)
      auth_token = AuthenticateUser.new(user.email, user.password).call
      response = { message: Message.account_created, auth_token: auth_token }
      json_response(response, :created)
    end
  
    private
  
    def user_params
      params.permit(
        :name,
        :email,
        :password,
        :password_confirmation
      )
    end
  end