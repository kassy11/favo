# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:twitter]

  validates :profile, length: { maximum: 500 }
  validates :name, presence: true
  validates :email, uniqueness: true

  has_many :movies
  has_many :musics
  has_many :books


  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first
    user ||= User.create(
      uid: auth.uid,
      provider: auth.provider,
      name: auth.info.name,
      profile: User.set_profile(auth),
      email: User.set_email(auth),
      image: User.set_image(auth),
      password: Devise.friendly_token[0, 20]
    )
    user
  end

  #def password_required?
  #  super && provider.blank?
  #end
  #
  #def email_required?
  #  super && provider.blank?
  #end
  #
  #def update_with_password(params, *options)
  #  if encrypted_password.blank?
  #    update_attributes(params, *options)
  #  else
  #    super
  #  end
  #end


  private

  def self.set_email(auth)
    auth.info.email || "#{auth.uid}-#{auth.provider}@example.com"
  end

  def self.set_profile(auth)
    auth.info.description
  end

  def self.set_image(auth)
    if auto.info.image.present?
      auth.info.image
    else
      "default_user.jpg"
    end
  end
end
