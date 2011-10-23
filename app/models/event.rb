class Event < ActiveRecord::Base
  has_many :pictures, :dependent => :destroy
  accepts_nested_attributes_for :pictures #, :reject_if => lambda {|a| a[:image].blank?}

  validates :title, :presence => true, :uniqueness => true
  validate :default_main_picture

  private

    def default_main_picture
      errors.add(:main_picture_no, "- One picture has to be selected") if !main_picture_no && !pictures.empty?
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

