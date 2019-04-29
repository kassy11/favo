Rails.application.routes.draw do
  devise_for :users
  get 'users/:id' => 'users#show'
  get 'musics/search' => 'musics#search'
  get 'musics/index' => 'musics#index'
  post 'musics/index' => 'musics#index'
  get 'books/search' => 'books#search'
  get 'books/index' => 'books#index'
  get 'movies/search' => 'movies#index'
  get 'movies/index' => 'movies#index'
  root 'static_pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
