# frozen_string_literal: true

class MusicsController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :search_param, only: :index
  GOOGLE_API_KEY = Rails.application.credentials.google[:api_key]

  include ApplicationHelper

  def find_videos(keyword)
    service = Google::Apis::YoutubeV3::YouTubeService.new
    service.key = GOOGLE_API_KEY

    opt = {
      q: keyword + ' official',
      type: 'video',
      max_results: 1,
      order: :relevance
    }
    service.list_searches(:snippet, opt)
  end

  def search; end

  def index
    if search_param['search'].present?
      @artists = search_artist(search_param['search'])
    end
    @base_contents = @artists
  end

  def show
    @artist = find_artist(params[:work_id])
    @albums = @artist.albums
    @top_tracks = @artist.top_tracks(:US).first(3)
    @title = @artist.name
    @genres = @artist.genres
    @spotify_link = @artist.external_urls['spotify']
    @img_url = @artist.images[1]['url'] if @artist.images.present?
    @youtube_data = find_videos(@title).items.first
  end

  def create
    @artist_fav = current_user.musics.new(artist_id: params[:work_id])
    @artist_fav.save
    redirect_to music_index_user_path(current_user), notice: 'ARTIST LISTの項目を追加しました'
  end

  def destroy
    @artist_fav = current_user.musics.find_by(artist_id: params[:work_id])
    @artist_fav.destroy
    redirect_to user_path(current_user), alert: 'ARTIST LISTの項目を削除しました'
  end
end
