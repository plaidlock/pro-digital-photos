class ImageUploader < CarrierWave::Uploader::Base
  # Manipulate images
  include CarrierWave::MiniMagick

  # Use file storage
  storage :file

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Create different versions for viewing
  #process :resize_to_limit => [800, 800]
  # version :thumb do
  #   process :resize_to_fill => [250, 150]
  # end
  
  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
