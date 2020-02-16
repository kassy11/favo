class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, :omniauth_providers => [:twitter]


  validates :profile, length: { maximum: 500 }

  has_many :movies
  has_many :musics
  has_many :books

  # アップロードする画像サイズのバリデーション
  # validates def check_imgae_dimenions
  #   if geometry[:width] < 200 || geometry[:height] < 200
  #     errors.add :image, '200x200ピクセル以上のサイズの画像をアップロードしてください'
  #   end
  # end
  #
  # def geometry
  #   @geometry ||= _geometry
  # end
  #
  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.create(
          uid:      auth.uid,
          provider: auth.provider,
          name: auth.info.name,
          profile: User.set_profile(auth),
          email: User.set_email(auth),
          # image: User.set_image(auth),
          password: Devise.friendly_token[0, 20]
      )
    end
    user
  end

  #class << self
  #  def find_for_oauth(auth)
  #    provider = auth[:provider]
  #    uid = auth[:uid]
  #    profile = auth.set_profile
  #    user_name = auth[:info][:name]
  #    image_url = auth[:info][:image]
  #    uri = URI.parse(image_url) # パースする必要がある
  #    image = uri.open
  #    email = auth.set_email
  #    password = Devise.friendly_token[0, 20]
  #
  #    find_or_create_by(provider: provider, uid: uid) do |user|
  #      user.name = user_name
  #      user.email = email
  #      user.password = password
  #      user.profile = profile
  #      user.avatar.attach(io: image, filename: "#{user.name}_profile.png")
  #    end
  #  end
  #end

  private

  def self.set_email(auth)
    if auth.info.email
      auth.info.email
    else
      "#{auth.uid}-#{auth.provider}@example.com"
    end
  end

  def self.set_profile(auth)
    if auth.info.description
      auth.info.description
    else
      "プロフィールを設定してね"
    end
  end

  # def self.set_image(auth)
  #   if auth.info.image
  #     uri = URI.parse(auth.info.image) # パースする必要がある
  #     uri.open
  #   end
  # end

  #def self.set_image(auth)
  #  if auth.info.image
  #    auth.info.image
  #end

  # def _geometry
  #   if image.file and File.exists?(image.file.file)
  #     img = ::Magick::Image::read(image.file.file).first
  #     { width: img.columns, height: img.rows }
  #   end
  # end
end
