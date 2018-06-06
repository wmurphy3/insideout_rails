class ImageUploader < Shrine
  plugin :remove_attachment
  plugin :processing
  plugin :versions
  plugin :validation_helpers

  Attacher.validate do
    validate_mime_type_inclusion %w[image/jpeg image/png image/jpg]
  end

  def generate_location(io, context)
    return unless ImageUploader.current_user

    extension = File.extname(extract_filename(io).to_s)
    "#{ImageUploader.current_user.client_id}/#{Time.now.strftime('%Y%m%d%H%M%S')}#{extension}"
  end

  class << self
    def current_user
      Thread.current[:current_user]
    end
  end
end
