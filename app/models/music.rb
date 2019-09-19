class Music < ApplicationRecord
  validates :user_id, {presence: true}
  validates :artist_id, {presence: true}
  belongs_to :user
  API_KEY = Rails.application.credentials.api[:spotify]
  API_KEY_SECRET = Rails.application.credentials.api[:spotify_secret]
end
