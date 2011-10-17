class Event < ActiveRecord::Base
  has_many :pictures
  accepts_nested_attributes_for :pictures, :reject_if => lambda {|a| a[:image].blank?}
  validate :default_main_picture

  before_save :nullify_main_picture_no_if_pictures_arent_present

  private

    def default_main_picture
      errors.add(:main_picture_no, "One picture has to be selected") if !main_picture_no && !pictures.empty?
    end

    def nullify_main_picture_no_if_pictures_arent_present
      self.main_picture_no = nil if pictures.empty?
    end
end

# == Schema Information
#
# Table name: events
#
#  id         :integer(4)      not null, primary key
#  start_date :date
#  end_date   :date
#  start_time :time
#  end_time   :time
#  title      :string(255)
#  content    :text
#  created_at :datetime
#  updated_at :datetime
#

