class MoviesController < ApplicationController
  require 'themoviedb-api'
  Tmdb::Api.key("df9c849f256c5f2784832a7eee5862e2")

  def search
  end

  def index
    logger.debug(params[:search])
    @movies = Tmdb::Search.movie(params[:search])
    logger.debug(@movies)
  end

  def show
  end

end
