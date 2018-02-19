class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :authenticate
    # return auth token once user is authenticated
    api :POST,  'auth/login' , "Login user and return auth token once user is authenticated"
    param :email, String, desc: 'Email nessessary for signup', :required => true
    param :password, String, desc: 'Password nessessary for signup', :required => true
    description <<-EOS 
    ###Example cURL
     curl \\
     -d email=[email] \\
     -d password=[password] \\
     http://localhost:3000/auth/login
  EOS
  example <<-EOS
    {
      "auth_token":"eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1MTkxMzA3MzF9.d3iMiRwoqE1P33VSYV6iuNpORQ58pxJyDD0H2DvLNOc"
    }
  EOS
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