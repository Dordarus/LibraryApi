Rails.application.routes.draw do 
  #start page routes
  get '/sign_up' => 'users#new', as: :sign_up
  get '/sign_in' => 'sessions#new', as: :sign_in

  #session routes
  post   '/sign_in' => 'sessions#create'
  delete '/sign_out'=> 'sessions#destroy', as: :sign_out

  #authors routes
  get '/authors'=>'authors#index', as: :authors_index
  post '/authors'=>'authors#create'
  get '/authors/:id' => 'authors#show', as: :author
  patch '/authors/:id' => 'authors#update'
  #books routes
  get '/books' => 'books#index', as: :books_index
  post '/books'=>'books#create'
  get '/books/:id'=> 'books#show', as: :book
  patch '/books/:id' => 'books#update'
  delete '/books/:id' => 'books#destroy'
end