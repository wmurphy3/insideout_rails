require "shrine"
require "shrine/storage/s3"

s3_options = {
  bucket:            'insideout-profile-pictures',
  region:            'us-east-1',
  access_key_id:     ENV['AWS_ID'],
  secret_access_key: ENV['AWS_SK']
}

Shrine.storages = {
  cache: Shrine::Storage::S3.new(prefix: "cache", upload_options: { acl: 'private'}, **s3_options),
  store: Shrine::Storage::S3.new(prefix: "uploads", upload_options: { acl: 'private'}, **s3_options)
}

Shrine.plugin :activerecord
Shrine.plugin :backgrounding
Shrine.plugin :logging
Shrine.plugin :determine_mime_type

Shrine::Attacher.promote { |data| PromoteJob.perform_later(data) }
