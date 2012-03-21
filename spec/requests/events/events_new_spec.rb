require 'spec_helper'

describe "Events" do
  describe "POST /events" do
    context "failes to create a new event" do
      before(:each) do
        login_admin
      end 

      it "since title is not filled in" do
        visit new_event_path
        lambda do
          fill_in "Title", :with => ""
          click_button "Create Event"
        end.should change(Event, :count).by(0)
        error_field.should have_content("can't be blank")
      end

      it "since title already exists" do
        Factory.create(:event, :title => "duplicated title")
        visit new_event_path
        lambda do
          fill_in "Title", :with => "duplicated title"
          click_button "Create Event"
        end.should change(Event, :count).by(0)
        error_field.should have_content("has already been taken")
      end

      it "image caption should still be shown" do
        visit new_event_path
        lambda do
          fill_in "Title", :with => ""
          fill_in "Caption", :with => "some caption"
          click_button "Create Event"
        end.should change(Event, :count).by(0)
        find_field("Caption").value.should == "some caption"
      end

      it "image should still be chosen" do
        visit new_event_path
        lambda do
          fill_in "Title", :with => ""
          attach_file("Image", File.expand_path("app/assets/images/rails.png"))
          click_button "Create Event"
        end.should change(Event, :count).by(0)
        page.should have_image("Thumb_rails") 
      end
    end

    context "creates a new event" do
      before(:each) do
        login_admin
        visit new_event_path
      end

      it "with title" do
        lambda do
          fill_in "Title", :with => "Rspec Title"
          click_button "Create Event"
        end.should change(Event, :count).by(1)
        Event.last.title.should == "Rspec Title"
        Event.last.main_picture_no.should be(-1)
      end

      it "with an image" do
        lambda do
          fill_in "Title", :with => "Random title"
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
