# frozen_string_literal: true

class BooksController < ApplicationController
  require 'net/http'
  require 'json'
  require 'uri'
  require 'base64'

  before_action :authenticate_user!, except: :show
  before_action :set_api, only: %i[show create]
  before_action :base_info, only: %i[show create]
  before_action :search_param, only: :index

  def search; end

  def index
    search_uri = "https://www.googleapis.com/books/v1/volumes?maxResults=40&orderBy=relevance&langRestrict=ja&"
    query = URI.encode_www_form(q: "#{search_param['search']}")
    enc_str = search_uri + query
    uri = URI.parse(enc_str)
    json = Net::HTTP.get(uri)
    @books = JSON.parse(json)
    @base_contents = @books['items']
  end

  def show
    @authors = @base_content['volumeInfo']['authors']
    @publisher = @base_content['volumeInfo']['publisher']
    @book_id = @base_content['id'].encode!
    @description = @base_content['volumeInfo']['description']
    @preview_link = @base_content['volumeInfo']['previewLink']
  end

  def create
    @book_fav = current_user.books.new(book_id: params[:work_id], book_name: @title, book_image_url: @img_url)
    @book_fav.save
    redirect_to book_index_user_path(current_user), notice: 'BOOK LISTの項目を追加しました'
  end

  def destroy
    @book_fav = current_user.books.find_by(book_id: params[:work_id])
    @book_fav.destroy
    redirect_to user_path(current_user), alert: 'BOOK LISTの項目を削除しました'
  end

  private

  def set_api
    url = "https://www.googleapis.com/books/v1/volumes/#{params[:work_id]}"
    uri = URI.parse(url)
    json = Net::HTTP.get(uri)
    @book = JSON.parse(json)
  end

  def base_info
    @base_content = @book
    if @base_content['volumeInfo']['imageLinks'].present?
      @img_url = @base_content['volumeInfo']['imageLinks']['thumbnail']
    end
    @title = @base_content['volumeInfo']['title']
  end
end
