module ApplicationHelper
  def find_artist(artist_id)
    RSpotify::Artist.find(artist_id)
  end

  def search_artist(artist_id)
    RSpotify::Artist.search(artist_id)
  end
end
