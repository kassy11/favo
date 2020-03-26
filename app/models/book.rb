# frozen_string_literal: true

class Book < ApplicationRecord
  validates :user_id, { presence: true }
  validates :book_id, { presence: true, uniqueness: true }
  belongs_to :user
end
