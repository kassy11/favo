class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # mount_uploader :image, ImageUploader

  # validates :name, presence: true#追記
  validates :profile, length: { maximum: 300 } #追記

  def my_musics
    return Music.where(user_id: self.id)
  end

  def my_books
    return Book.where(user_id: self.id)
  end
end
