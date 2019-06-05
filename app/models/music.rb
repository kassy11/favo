class Music < ApplicationRecord
  validates :user_id, {presence: true}
  validates :artist_id, {presence: true}

end
