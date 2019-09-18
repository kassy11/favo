class Movie < ApplicationRecord
  validates :user_id, {presence: true}
  validates :movie_id, {presence: true}
  belongs_to :user
end
