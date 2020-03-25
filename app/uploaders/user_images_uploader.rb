# frozen_string_literal: true

class UserImagesUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # if Rails.env.production?
  #   include Cloudinary::CarrierWave
  #   process resize_to_fit: [250,250]
  # else
  #   include CarrierWave::RMagick
  #   process resize_to_fit: [250,250]
  #   storage :file
  #   def store_dir
  #     "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  #   end
  # end

  storage :file

  process convert: 'jpg'

  # 保存するディレクトリ名
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # thumb バージョン(width 400px x height 200px)

  # 許可する画像の拡張子
  def extension_white_list
    %w[jpg jpeg gif png]
  end

  # 変換したファイルのファイル名の規則
  def filename
    if original_filename.present?
      "#{Time.zone.now.strftime('%Y%m%d%H%M%S')}.jpg"
    end
  end
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process resize_to_fit: [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end
