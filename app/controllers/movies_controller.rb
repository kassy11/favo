class MoviesController < ApplicationController
  require 'net/http'
  require "json"
  require 'uri'

  def index
    search_uri = "https://api.themoviedb.org/3/search/movie?api_key=df9c849f256c5f2784832a7eee5862e2&query=#{params[:search]}"
    enc_uri = URI.encode(search_uri)
    uri = URI.parse(enc_uri)
    json = Net::HTTP.get(uri) #NET::HTTPを利用してAPIを叩く
    @movies = JSON.parse(json) #返り値をrubyの配列に変換

  end

  def show
  end

  def create
  end

  def destroy
  end

end
