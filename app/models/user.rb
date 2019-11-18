class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, :omniauth_providers => [:twitter]

  validates :profile, length: { maximum: 300 }

  has_many :movies
  has_many :musics
  has_many :books

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.create(
          uid:      auth.uid,
          provider: auth.provider,
          name: auth.info.name,
          profile: User.set_profile(auth),
          email: User.set_email(auth),
          image: User.set_image(auth),
          password: Devise.friendly_token[0, 20]
      )
    end

    user
  end

  private

  def self.set_email(auth)
    if auth.info[:email].nil?
      "#{auth.uid}-#{auth.provider}@example.com"
    else
      auth.info[:email]
    end
  end

  def self.set_profile(auth)
    if auth.info.description.nil?
      "プロフィールを設定してね"
    else
      auth.info.description
    end
  end

  def self.set_image(auth)
    if auth.info.image.nil?
      "dora.jpg"
    else
      auth.info.image
    end
  end
end
