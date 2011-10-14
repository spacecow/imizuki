class Picture < ActiveRecord::Base
  belongs_to :event
  mount_uploader :image, ImageUploader

  def filename
    image.url && image.url.split("/")[-1]
  end
end
