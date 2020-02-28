Rails.application.routes.draw do

  get 'musics/search' => 'musics#search'
  get 'books/search' => 'books#search'
  get 'movies/search' => 'movies#search'

  get 'musics/index' => 'musics#index'
  get 'books/index' => 'books#index'
  get 'movies/index' => 'movies#index'

  post "musics/:work_id/create" => "musics#create", as: :musics
  post "movies/:work_id/create" => "movies#create", as: :movies
  post "books/:work_id/create" => "books#create", as: :books
  ## TODO:ここの上下３つをどうにかまとめたい..

  resources :musics, :books, :movies, only: [ :destroy, :show ], param: :work_id

  devise_for :users, :controllers => { registrations: 'registrations', omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :users, only: :show do
    get :book_index, on: :member
    get :music_index, on: :member
    get :movie_index, on: :member
  end

  root 'static_pages#home'
end
