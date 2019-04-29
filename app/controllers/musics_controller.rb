class MusicsController < ApplicationController
  require 'rspotify'
  RSpotify.authenticate("6de2473819924e0c99991cda7f21a08d", "eaa2510f8bdc4c08a94900a34af51587")

  def search
  end

  def index
    @artists = RSpotify::Artist.search(params[:search])
  end
end
