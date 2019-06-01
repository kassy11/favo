Rails.application.routes.draw do
  post "musics/:artist_id/create" => "musics#create",param: :artist_id
  post "musics/:artist_id/destroy" => "musics#destroy", param: :artist_id

  devise_for :users
  resources :users, only: [:show]

  get 'musics/search' => 'musics#search'
  post 'musics/index' => 'musics#index'
  resources :musics, only: :show, param: :artist_id

  get 'books/search' => 'books#search'
  post 'books/index' => 'books#index'

  get 'movies/search' => 'movies#search'
  post 'movies/index' => 'movies#index'

  root 'static_pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
