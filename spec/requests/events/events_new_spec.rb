require 'spec_helper'

describe "Events" do
  describe "POST /events" do
    context "creates a new event" do
      before(:each) do
        login_and_create_user("test","secret")
        visit new_event_path
      end

      it "with title" do
        lambda do
          fill_in "Title", :with => "Rspec Title"
          click_button "Create Event"
        end.should change(Event, :count).by(1)
        Event.last.title.should == "Rspec Title"
        Event.last.main_picture_no.should be(nil)
      end

      it "with an image" do
        lambda do
          attach_file("Image", File.expand_path("app/assets/images/rails.png"))
          fill_in "Caption", :with => "Rspec Caption"
          click_button "Create Event"
        end.should change(Event, :count).by(1)
        pic = Picture.last
        pic.filename.should == "rails.png"
        pic.caption.should == "Rspec Caption"
        Event.last.main_picture_no.should be(0)
      end
    end
  end
end
