class Movie < ApplicationRecord
  validates :user_id, {presence: true}
  validates :movie_id, {presence: true}
  belongs_to :user
  API_KEY = Rails.application.credentials.moviedb[:api_key]
  YOUTUBE_KEY = Rails.application.credentials.youtube[:api_key]
end
