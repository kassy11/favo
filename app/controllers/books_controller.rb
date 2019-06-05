class BooksController < ApplicationController
  require 'net/http'
  require "json"
  require 'uri'

  def index
    url = 'https://www.googleapis.com/books/v1/volumes?q='
    request = url + params[:search]
    enc_str = URI.encode(request)
    uri = URI.parse(enc_str)
    json = Net::HTTP.get(uri)
    @books = JSON.parse(json)
  end

  def show
    url = "https://www.googleapis.com/books/v1/volumes?q=id:#{params[:book_id]}"
    enc_str = URI.encode(url)
    uri = URI.parse(enc_str)
    json = Net::HTTP.get(uri)
    @book = JSON.parse(json)
  end

  def create
    url = "https://www.googleapis.com/books/v1/volumes?q=id:#{params[:book_id]}"
    enc_str = URI.encode(url)
    uri = URI.parse(enc_str)
    json = Net::HTTP.get(uri)
    @book = JSON.parse(json)

    title = @book["items"][0]["volumeInfo"]["title"]
    img_url = @book["items"][0]["volumeInfo"]["imageLinks"]["smallThumbnail"]

    @book_fav = Book.new(user_id: current_user.id, book_id: params[:book_id], book_name: title, book_image_url: img_url )
    @book_fav.save
    redirect_to("/users/#{current_user.id}/book_index")
  end

  def destroy
    @book_fav = Book.find_by(user_id: current_user.id, book_id: params[:book_id])
    @book_fav.destroy
    redirect_to("/users/#{current_user.id}/book_index")
  end
end
