class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, :omniauth_providers => [:twitter]

  mount_uploader :image, UserImageUploader

  validates :profile, length: { maximum: 300 }

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
      "default.png"
    else
      auth.info.image.sub("_bigger","")
    end
  end

  # def _geometry
  #   if image.file and File.exists?(image.file.file)
  #     img = ::Magick::Image::read(image.file.file).first
  #     { width: img.columns, height: img.rows }
  #   end
  # end
end
