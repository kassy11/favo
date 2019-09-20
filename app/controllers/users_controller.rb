class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @user = current_user
  end

  def music_index
    @my_musics = current_user.musics
  end

  def movie_index
    @my_movies = current_user.movies
  end

  def book_index
    @my_books = current_user.books
  end
end
