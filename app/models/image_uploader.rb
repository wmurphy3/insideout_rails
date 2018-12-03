class ImageUploader < Shrine
  plugin :remove_attachment
  plugin :processing
  plugin :versions
  plugin :validation_helpers

  Attacher.validate do
    validate_mime_type_inclusion %w[image/jpeg image/png image/jpg]
  end

end
