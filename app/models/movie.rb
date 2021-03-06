# frozen_string_literal: true

class Movie < ApplicationRecord
  validates :user_id, { presence: true }
  validates :movie_id, { presence: true, uniqueness: { scope: :user_id } }
  belongs_to :user, foreign_key: :user_id
  API_KEY = Rails.application.credentials.moviedb[:api_key]
  GOOGLE_API_KEY = Rails.application.credentials.google[:api_key]
end
