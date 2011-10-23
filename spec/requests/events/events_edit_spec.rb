require 'spec_helper'

describe "Events" do
  describe "PUT /events" do
    before(:each) do
      login_and_create_user("test","secret")
      @event = Event.create!(:title => "Opening")
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
        @pic1 = Picture.create!(:image => File.open("spec/rails.png"), :event_id => @event.id)
        @pic2 = Picture.create!(:image => File.open("spec/rails2.png"), :event_id => @event.id)
      end

      it "display" do
        visit edit_event_path(@event)
        fieldset("image",0).should have_content("rails.png")
        fieldset("image",1).should have_content("rails2.png")
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
