class MoviesController < ApplicationController
  require 'net/http'
  require "json"
  require 'uri'
  require 'google/apis/youtube_v3'
  require 'active_support/all'

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
    @video = find_videos(@title).first
  end

  def create
    img_url = "https://image.tmdb.org/t/p/w154/#{@img_path}"
    @movie_fav = current_user.movies.new(movie_id: params[:movie_id], movie_name: @title, movie_image_url: img_url)
    @movie_fav.save
    redirect_to my_movie_path(current_user)
  end

  def destroy
    @movie_fav = current_user.movies.find_by(movie_id: params[:movie_id])
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

  def base_info
    @title = @movie["title"]
    @img_path = @movie["poster_path"]
  end

  def find_videos(keyword, after: 10.years.ago, before: Time.now)
    service = Google::Apis::YoutubeV3::YouTubeService.new
    service.key = Movie::YOUTUBE_KEY

    next_page_token = nil
      opt = {
          q: keyword + '　予告',
          type: 'video',
          max_results: 1,
          order: :date,
          page_token: next_page_token,
          published_after: after.iso8601,
          published_before: before.iso8601
      }
      service.list_searches(:snippet, opt)
  end

end
