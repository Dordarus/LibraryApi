class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :authenticate
    # return auth token once user is authenticated
    api :POST,  'auth/login' , "Login user and return auth token once user is authenticated"
    param :user, Hash, desc: 'User information' do 
      param :email, String, desc: 'Email nessessary for signup', :required => true
      param :password, String, desc: 'Password nessessary for signup', :required => true
    end
    def authenticate
      auth_token =
        AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
      json_response(auth_token: auth_token)
    end
  
    private
  
    def auth_params
      params.permit(:email, :password)
    end
  end