class MoviesController < ApplicationController
  before_action :set_api, only: [:show, :create]
  require 'net/http'
  require "json"
  require 'uri'
  
  def index
    search_uri = "https://api.themoviedb.org/3/search/movie?api_key=df9c849f256c5f2784832a7eee5862e2&language=ja-JA&query=#{params[:search]}"
    enc_uri = URI.encode(search_uri)
    uri = URI.parse(enc_uri)
    json = Net::HTTP.get(uri) #NET::HTTPを利用してAPIを叩く
    @movies = JSON.parse(json) #返り値をrubyの配列に変換
  end

  def show
  end

  def create
    title = @movie["title"]
    img_path = @movie["poster_path"]
    img_url = "https://image.tmdb.org/t/p/w154/#{img_path}"

    @movie_fav = Movie.new(user_id: current_user.id, movie_id: params[:movie_id], movie_name: title, movie_image_url: img_url )
    @movie_fav.save
    redirect_to my_movie_path(current_user)
  end

  def destroy
    @movie_fav = Movie.find_by(user_id: current_user.id, movie_id: params[:movie_id])
    @movie_fav.destroy
    redirect_to my_movie_path(current_user)
  end

  private 

  def set_api
    search_uri = "https://api.themoviedb.org/3/movie/#{params[:movie_id]}?api_key=df9c849f256c5f2784832a7eee5862e2&language=ja-JA"
    enc_uri = URI.encode(search_uri)
    uri = URI.parse(enc_uri)
    json = Net::HTTP.get(uri)
    @movie = JSON.parse(json)
  end
end
