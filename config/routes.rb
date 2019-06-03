Rails.application.routes.draw do
  post "musics/:artist_id/create" => "musics#create",param: :artist_id
  post "musics/:artist_id/destroy" => "musics#destroy", param: :artist_id

  post "books/:book_id/create" => "books#create",param: :book_id
  post "books/:book_id/destroy" => "books#destroy", param: :book_id

  post "movies/:movie_id/create" => "movies#create",param: :movie_id
  post "movies/:movie_id/destroy" => "movies#destroy", param: :movie_id


  devise_for :users
  get 'users/:id' => 'users#show', as: :mypage

  get 'users/:id/music_index' => 'users#music_index', as: :my_music
  post 'musics/index' => 'musics#index'
  resources :musics, only: :show, param: :artist_id

  get 'users/:id/book_index' => 'users#book_index', as: :my_book
  post 'books/index' => 'books#index'
  resources :books, only: :show, param: :book_id

  get 'users/:id/movie_index' => 'users#movie_index', as: :my_movie
  post 'movies/index' => 'movies#index'
  resources :movies, only: :show, param: :movie_id

  root 'static_pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
