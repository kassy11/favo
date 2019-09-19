class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # validates :name, presence: true#追記
  validates :profile, length: { maximum: 300 }

  has_many :movies
  has_many :musics
  has_many :books
end
