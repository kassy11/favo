# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book, type: :model do
  it 'is valid with user_id and book_id' do
    book = build_stubbed(:book)
    expect(book).to be_valid
  end

  it 'is invalid without book_id' do
    book = build_stubbed(:book, book_id: nil)
    book.valid?
    expect(book).to be_invalid
  end

  it 'is invalid without user_id' do
    book = build_stubbed(:book, user_id: nil)
    book.valid?
    expect(book).to be_invalid
  end

  it 'is invalid with duplicate artist_id by same user' do
    user = create(:user)
    create(:book, book_id: '24ce8dbd-ce7d-4352-ad3f-7dff62fbf5a9', user: user)
    book2 = build_stubbed(:book, book_id: '24ce8dbd-ce7d-4352-ad3f-7dff62fbf5a9', user: user)
    book2.valid?
    expect(book2).to be_invalid
  end
end
