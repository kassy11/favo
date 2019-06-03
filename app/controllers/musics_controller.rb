class MusicsController < ApplicationController
  require 'rspotify'
  RSpotify.authenticate("6de2473819924e0c99991cda7f21a08d", "eaa2510f8bdc4c08a94900a34af51587")

  def index
    @artists = RSpotify::Artist.search(params[:search])
  end

  def show
    @artist = RSpotify::Artist.find(params[:artist_id])
  end

  def create
    @artist_fav = Music.new(user_id: current_user.id, artist_id: params[:artist_id])
    @artist_fav.save
    redirect_to("/users/#{current_user.id}/music_index")
  end

  def destroy
    @artist_fav = Music.find_by(user_id: current_user.id, artist_id: params[:artist_id])
    @artist_fav.destroy
    redirect_to("/users/#{current_user.id}/music_index")
  end
end
