Rails.application.routes.draw do 
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'

  #authors routes
  get '/authors'=>'authors#index', as: :authors_index
  post '/authors'=>'authors#create'
  get '/authors/:id' => 'authors#show', as: :author
  patch '/authors/:id' => 'authors#update'
  delete '/authors/:id' => 'authors#destroy'
  #books routes
  get '/books' => 'books#index', as: :books_index
  post '/books'=>'books#create'
  get '/books/:id'=> 'books#show', as: :book
  patch '/books/:id' => 'books#update'
  delete '/books/:id' => 'books#destroy'
end