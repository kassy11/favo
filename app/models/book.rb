class Book < ApplicationRecord
  validates :user_id, {presence: true}
  validates :book_id, {presence: true}

  # def book_fav
  #   @book_fav = Book.find_by(id: self.artist_id)
  # end
end
