class Music < ApplicationRecord
  validates :user_id, {presence: true}
  validates :artist_id, {presence: true, uniqueness: true}
  belongs_to :user
  require 'rspotify'
  API_KEY = Rails.application.credentials.spotify[:api_key]
  API_KEY_SECRET = Rails.application.credentials.spotify[:api_secret_key]
  RSpotify.authenticate("#{API_KEY}", "#{API_KEY_SECRET}")
end
