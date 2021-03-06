# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:twitter]

  validates :name, presence: true
  validates :email, uniqueness: true

  has_many :movies, dependent: :destroy
  has_many :musics, dependent: :destroy
  has_many :books, dependent: :destroy

  has_one_attached :image
  require 'open-uri'

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    user ||= User.create(
      uid: auth.uid,
      provider: auth.provider,
      name: auth.info.name,
      profile: set_profile(auth),
      email: set_email(auth),
      password: Devise.friendly_token[0, 20]
    )
    user
  end

  class << self
    private

    def set_email(auth)
      auth.info.email || "#{auth.uid}-#{auth.provider}@example.com"
    end

    def set_profile(auth)
      auth.info.description
    end
  end
end
