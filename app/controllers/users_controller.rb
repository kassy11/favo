class UsersController < ApplicationController
# before_action :authenticate_user!

  def show
    @user = User.find_by(id: current_user.id)
  end

  def music_index
    @user = User.find_by(id: current_user.id)
  end

  def movie_index
    @user = User.find_by(id: current_user.id)
    @my_movies = @user.my_movies
  end

  def book_index
    @user = User.find_by(id: current_user.id)
    @my_books = @user.my_books
  end
end
