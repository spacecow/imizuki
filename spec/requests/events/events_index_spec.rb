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

    context "not logged in" do
      it "cannot see new event link" do
        visit events_path
        page.should_not have_link("New Event")
      end
    end

    context "user actions" do
      before(:each) do
        login_and_create_user("test","secret")
        visit events_path
      end

      context "delete" do
        it "an event" do
          lambda do
            click_link "Del" 
          end.should change(Event, :count).by(-1)
        end

        it "an event with a picture" do
          Picture.create!(:image => File.open("spec/rails.png"), :event_id => @event.id)
          lambda do
            click_link "Del"
          end.should change(Picture, :count).by(-1)
        end
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
end
