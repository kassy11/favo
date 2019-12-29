class MusicsController < ApplicationController
  include ApplicationHelper

  def index
    @artists = search_artist(params[:search]) unless params[:search].blank?
    @base_contents = @artists
  end

  def show
    @artist = find_artist(params[:artist_id])
    @title = @artist.name
    @img_url = @artist.images[1]["url"] unless @artist.images.blank?
  end

  def create
    @artist_fav = current_user.musics.new(artist_id: params[:artist_id])
    @artist_fav.save
    redirect_to my_music_path(current_user), notice: 'MUSIC LISTの項目を追加しました'
  end

  def destroy
    @artist_fav = current_user.musics.find_by(artist_id: params[:artist_id])
    @artist_fav.destroy
    redirect_to my_music_path(current_user), alert: 'MOVIE LISTの項目を削除しました'
  end
end
