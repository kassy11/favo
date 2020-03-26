# frozen_string_literal: true

class Music < ApplicationRecord
  validates :user_id, { presence: true }
  validates :artist_id, { presence: true, uniqueness: { scope: :user_id } }
  belongs_to :user
  require 'rspotify'
  API_KEY = Rails.application.credentials.spotify[:api_key]
  API_KEY_SECRET = Rails.application.credentials.spotify[:api_secret_key]
  RSpotify.authenticate(API_KEY.to_s, API_KEY_SECRET.to_s)
end
