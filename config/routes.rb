Rails.application.routes.draw do

  post "musics/:work_id/create" => "musics#create", as: :musics
  post "movies/:work_id/create" => "movies#create", as: :movies
  post "books/:work_id/create" => "books#create", as: :books
  resources :musics, :books, :movies, only: [ :destroy, :show ], param: :work_id

  ## ここの上下３つをどうにかまとめたい..
  post 'musics/index' => 'musics#index'
  post 'books/index' => 'books#index'
  post 'movies/index' => 'movies#index'
  # getに書き換える


  devise_for :users, :controllers => { registrations: 'registrations', omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, only: :show do
    get :book_index, on: :member
    get :music_index, on: :member
    get :movie_index, on: :member
  end

  root 'static_pages#home'
end
