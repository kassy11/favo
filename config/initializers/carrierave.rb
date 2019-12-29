# require 'carrierwave/storage/abstract'
# require 'carrierwave/storage/file'
# require 'carrierwave/storage/fog'
# require 'fog/aws'

# CarrierWave.configure do |config|
#   if Rails.env.test?
#     config.storage :file
#     config.asset_host = 'http://localhost:3000'
#   else
#     config.storage = :fog
#     config.fog_provider = 'fog/aws'
#     config.fog_use_ssl_for_aws = true
#     config.fog_directory  = 'image-for-favo'
#     config.fog_public     = true
#     config.fog_attributes = { 'Cache-Control': 'max-age=315576000' }
#     config.asset_host = 'https://s3.amazonaws.com/website'

#     config.fog_credentials = {
#         provider:               'AWS',
#         region: 'ap-northeast-1',
#         use_iam_profile: true
#         # aws_access_key_id:      Rails.application.credentials.aws[:access_key_id],
#         # aws_secret_access_key:  Rails.application.credentials.aws[:secret_access_key],
#         # path_style:             true
#     }
#   end
# end
# CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/
