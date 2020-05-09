# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :set_user
  before_action :current_user_index!, except: :show

  def show; end

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

  def current_user_index!
    redirect_to root_path if current_user.id != params[:id].to_i
  end
end
