class BooksController < ApplicationController
  require 'net/http'
  require "json"
  require 'uri'

  def search
  end

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
  end

  def destroy
  end
end
