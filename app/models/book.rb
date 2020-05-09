# frozen_string_literal: true

class Book < ApplicationRecord
  validates :user_id, { presence: true }
  validates :book_id, { presence: true, uniqueness: { scope: :user_id } }
  belongs_to :user, foreign_key: :user_id
end
