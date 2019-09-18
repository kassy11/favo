class BooksController < ApplicationController
  require 'net/http'
  require "json"
  require 'uri'

  before_action :set_api, only: [:show, :create]

  def index
    url = 'https://www.googleapis.com/books/v1/volumes?q='
    request = url + params[:search]
    enc_str = URI.encode(request)
    uri = URI.parse(enc_str)
    json = Net::HTTP.get(uri)
    @books = JSON.parse(json)
  end

  def show
  end

  def create
    title = @book["items"][0]["volumeInfo"]["title"]
    img_url = @book["items"][0]["volumeInfo"]["imageLinks"]["smallThumbnail"]

    @book_fav = current_user.books.new(book_id: params[:book_id], book_name: title, book_image_url: img_url )
    @book_fav.save
    redirect_to("/users/#{current_user.id}/book_index")
  end

  def destroy
    @book_fav = current_user.books.find_by(book_id: params[:book_id])
    @book_fav.destroy
    redirect_to my_book_path(current_user)
  end

  private 

  def set_api
    url = "https://www.googleapis.com/books/v1/volumes?q=id:#{params[:book_id]}"
    enc_str = URI.encode(url)
    uri = URI.parse(enc_str)
    json = Net::HTTP.get(uri)
    @book = JSON.parse(json)
  end
end
