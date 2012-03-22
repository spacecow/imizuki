require 'spec_helper'

describe Event do
  before(:each) do
    @event = Factory(:event)
  end

  context "delete an event" do
    it "its pictures get deleted too" do
      Factory(:picture, image:File.open("spec/rails.png"), event_id:@event.id)
      lambda{ @event.destroy
      }.should change(Picture,:count).by(-1)
    end
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

