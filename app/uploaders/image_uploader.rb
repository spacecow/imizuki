# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  # Include RMagick or ImageScience support:
  # include CarrierWave::MiniMagick
  # include CarrierWave::ImageScience

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    #"/app/assets/images/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Rotates the image based on the EXIF Orientation
  def fix_exif_rotation
    manipulate! do |img|
      img.auto_orient!
      img = yield(img) if block_given?
      img
    end
  end
  # Strips out all embedded information from the image
  def strip
    manipulate! do |img|
      img.strip!
      img = yield(img) if block_given?
      img
    end
  end

  #Create different versions of your uploaded files:
  version :thumb do
    #process :resize_to_limit => [56, 56]
    #process :resize_to_fit => [56, 56]
    process :resize_to_fill => [56, 56]
  end
  
  version :iphone do
    process :fix_exif_rotation
    process :strip
    process :resize_to_limit => [320, 480]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
