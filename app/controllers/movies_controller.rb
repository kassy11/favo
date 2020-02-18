class MoviesController < ApplicationController
  require 'net/http'
  require "json"
  require 'uri'

  before_action :set_api, only: [:show, :create]
  before_action :base_info, only: [:show, :create]
  
  def index
    search_uri = "https://api.themoviedb.org/3/search/movie?api_key=#{Movie::API_KEY}&language=ja-JA&query=#{params[:search]}"
    enc_uri = URI.encode(search_uri)
    uri = URI.parse(enc_uri)
    json = Net::HTTP.get(uri)
    @movies = JSON.parse(json)
    @base_contents = @movies["results"]
  end

  def show
    @movie_id = @movie["id"]
    @overview = @movie["overview"]
    @img_url = "https://image.tmdb.org/t/p/w342/#{@img_path}"
    @release_date = @movie["release_date"]
    @genres = @movie["genres"]
  end

  def create
    img_url = "https://image.tmdb.org/t/p/w154/#{@img_path}"
    @movie_fav = current_user.movies.new(movie_id: params[:work_id], movie_name: @title, movie_image_url: img_url)
    @movie_fav.save
    redirect_to movie_index_user_path(current_user), notice: 'MOVIE LISTの項目を追加しました'
  end

  def destroy
    @movie_fav = current_user.movies.find_by(movie_id: params[:work_id])
    @movie_fav.destroy
    redirect_to movie_index_user_path(current_user), alert: 'MOVIE LISTの項目を削除しました'
  end

  private 

  def set_api
    search_uri = "https://api.themoviedb.org/3/movie/#{params[:work_id]}?api_key=#{Movie::API_KEY}&language=ja-JA"
    enc_uri = URI.encode(search_uri)
    uri = URI.parse(enc_uri)
    json = Net::HTTP.get(uri)
    @movie = JSON.parse(json)
  end

  def base_info
    @title = @movie["title"]
    @img_path = @movie["poster_path"]
  end
end
