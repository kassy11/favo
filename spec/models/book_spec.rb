# frozen_string_literal: true

require 'rails_helper'

describe Book do
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

  it 'is invalid with duplicate artist_id' do
    book1 = create(:book, book_id: '24ce8dbd-ce7d-4352-ad3f-7dff62fbf5a9')
    book2 = build_stubbed(:book, book_id: '24ce8dbd-ce7d-4352-ad3f-7dff62fbf5a9')
    book2.valid?
    expect(book2).to be_invalid
  end
end
