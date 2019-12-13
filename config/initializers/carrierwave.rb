require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider               => 'AWS',
      aws_access_key_id      => ENV['S3_ACCESS_KEY'],
      aws_secret_access_key  => ENV['S3_SECRET_KEY'],
      region                 => ENV['S3_REGION'],  # S3バケット作成時に指定したリージョン。バージニア北部
    }
    config.fog_directory  = ENV['S3_BUCKET'] # 作成したS3バケット名
  end
  # 日本語ファイル名の設定
  CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/ 
end