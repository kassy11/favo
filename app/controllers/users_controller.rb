class UsersController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :set_user
  
  def show
  end

  def music_index
    @my_musics = @user.musics
  end

  def movie_index
    @my_movies = @user.movies
  end

  def book_index
    @my_books = @user.books
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
