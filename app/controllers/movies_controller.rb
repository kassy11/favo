class MoviesController < ApplicationController
  require 'net/http'
  require "json"
  require 'uri'

  def search
  end

  def index
    search_uri = "https://api.themoviedb.org/3/search/movie?api_key=df9c849f256c5f2784832a7eee5862e2&query=#{params[:search]}"
    uri = URI.parse(search_uri)
    json = Net::HTTP.get(uri) #NET::HTTPを利用してAPIを叩く
    @movies = JSON.parse(json) #返り値をrubyの配列に変換

  end

  # def show
  #   @movie_info = Movie.details(params[:id])
  # end

end
