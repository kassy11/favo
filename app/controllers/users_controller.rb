class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  
  def show
  end

  def music_index
  end

  def movie_index
    @my_movies = @user.movies
  end

  def book_index
    @my_books = @user.books
  end

  private 

  def set_user
    @user = User.find_by(id: current_user.id)
  end
end
