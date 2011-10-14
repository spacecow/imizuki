require 'spec_helper'

describe "Events" do
  describe "GET /events" do
    before(:each) do
      @event = Event.create(:title => "Opening")
    end

    it "list events" do
      visit events_path
      page.should have_content("Opening")
    end

    it "show an event" do
      visit events_path
      click_link "Opening"
      page.current_path.should == event_path(@event)
    end

    context "user actions" do
      before(:each) do
        login_and_create_user("test","secret")
        visit events_path
      end

      it "delete an event" do
        lambda do
          click_link "Del" 
        end.should change(Event, :count).by(-1)
      end

      it "edit an event" do
        click_link "Edit"
        page.current_path.should == edit_event_path(@event)
      end

      it "add an event" do
        click_link "New Event"
        page.current_path.should == new_event_path
      end
    end
  end

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
        Event.last.main_picture_id.should be(nil)
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
        Event.last.main_picture_id.should be(0)
      end
    end
  end

  describe "PUT /events" do
    before(:each) do
      login_and_create_user("test","secret")
    end

    it "edit an event" do
      event = Event.create!(:title => "Opening")
      visit edit_event_path(event)
      fill_in "Title", :with => "Ending"
      click_button "Update Event"
      Event.find_by_title("Ending").should_not be(nil)
    end

    context "attached pictures" do
      before(:each) do
        @event = Event.create!(:title => "Opening")
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
          @event.update_attribute(:main_picture_id, 0) 
          visit edit_event_path(@event)
          radio(:within => fieldset("image",0)).should be_checked
          radio(:within => fieldset("image",1)).should_not be_checked
        end

        it "the second" do
          @event.update_attribute(:main_picture_id, 1) 
          visit edit_event_path(@event)
          radio(:within => fieldset("image",0)).should_not be_checked
          radio(:within => fieldset("image",1)).should be_checked
        end
      end
    end
  end
end
