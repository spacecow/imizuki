class Event < ActiveRecord::Base
  has_many :pictures, :dependent => :destroy
  accepts_nested_attributes_for :pictures
  validate :default_main_picture

  def main_image_url(ver=nil); main_picture.image_url(ver) end
  def main_picture; pictures[main_picture_no] || default_picture end

  private

    def default_main_picture
      errors.add(:main_picture_no, "- One picture has to be selected") if !main_picture_no && !pictures.empty?
    end
    def default_picture
      Picture.new(:image => File.open("app/assets/images/default.png")) 
    end

    def nullify_main_picture_no_if_pictures_arent_present
      self.main_picture_no = nil if pictures.empty?
    end
end


# == Schema Information
#
# Table name: events
#
#  id              :integer(4)      not null, primary key
#  start_date      :date
#  end_date        :date
#  start_time      :time
#  end_time        :time
#  title           :string(255)
#  content         :text
#  created_at      :datetime
#  updated_at      :datetime
#  main_picture_no :integer(4)      default(0)
#

