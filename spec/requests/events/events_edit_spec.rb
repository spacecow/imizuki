require 'spec_helper'

describe "Events" do
  describe "PUT /events" do
    before(:each) do
      login_and_create_user("test","secret")
      @event = Event.create!(:title => "Opening")
    end

    context "failes to edit an event" do
      before(:each) do
        visit edit_event_path(@event)
      end

      it "since title is not filled in" do
        fill_in "Title", :with => ""
        click_button "Update Event"
        error_field.should have_content("can't be blank")
      end

      it "since title already exists" do
        fill_in "Title", :with => "Opening"
        click_button "Update Event"
        error_field.should have_content("has already been taken")
      end

      it "image caption should still be shown" do
        fill_in "Title", :with => ""
        fill_in "Caption", :with => "some caption"
        click_button "Update Event"
        find_field("Caption").value.should == "some caption"
      end

      it "image should still be chosen" do
        lambda do
          fill_in "Title", :with => ""
          attach_file("Image", File.expand_path("app/assets/images/rails.png"))
          click_button "Create Event"
        end.should change(Event, :count).by(0)
        page.should have_image("Thumb_rails") 
      end
    end

    it "edit an event" do
      visit edit_event_path(@event)
      fill_in "Title", :with => "Ending"
      click_button "Update Event"
      Event.find_by_title("Ending").should_not be(nil)
      Event.last.main_picture_no.should be(nil)
    end

    it "attach a picture" do
      visit edit_event_path(@event)
      lambda do
        attach_file("Image", File.expand_path("app/assets/images/rails.png"))
        click_button "Update Event"
      end.should change(Picture, :count).by(1)
    end 

    context "attached pictures" do
      before(:each) do
        @pic1 = create_pic("rails.png", @event)
        @pic2 = create_pic("rails2.png", @event)
      end

      it "display" do
        visit edit_event_path(@event)
        fieldset("image",0).should have_image("Thumb_rails")
        fieldset("image",1).should have_image("Thumb_rails2")
      end

      context "indicate main picture as" do
        it "the first" do
          @event.update_attribute(:main_picture_no, 0) 
          visit edit_event_path(@event)
          radio(:within => fieldset("image",0)).should be_checked
          radio(:within => fieldset("image",1)).should_not be_checked
        end

        it "the second" do
          @event.update_attribute(:main_picture_no, 1) 
          visit edit_event_path(@event)
          radio(:within => fieldset("image",0)).should_not be_checked
          radio(:within => fieldset("image",1)).should be_checked
        end
      end
    end
  end
end