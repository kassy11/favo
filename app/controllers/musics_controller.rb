class MusicsController < ApplicationController
  require 'rspotify'
  RSpotify.authenticate("6de2473819924e0c99991cda7f21a08d", "dad4a720264d46fd881f34a6c02f9156")

  def index
    @artists = RSpotify::Artist.search(params[:search])
    binding.pry
  end

  def show
    @artist = RSpotify::Artist.find(params[:artist_id])
    binding.pry
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
