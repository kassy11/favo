class Music < ApplicationRecord
  validates :user_id, {presence: true}
  validates :artist_id, {presence: true}

  # def artist_
  #   @music_fav = Music.find_by(id: self.artist_id)
  # end

end
