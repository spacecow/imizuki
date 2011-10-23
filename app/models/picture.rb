class Picture < ActiveRecord::Base
  belongs_to :event
  mount_uploader :image, ImageUploader
  after_save :check_picture

  def filename
    image.url && image.url.split("/")[-1]
  end

  private

    def check_picture
      self.destroy if self.image.url.nil?
    end
end

# == Schema Information
#
# Table name: pictures
#
#  id         :integer(4)      not null, primary key
#  image      :string(255)
#  caption    :string(255)
#  event_id   :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

