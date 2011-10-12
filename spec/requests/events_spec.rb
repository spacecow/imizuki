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
    end
  end

  describe "POST /events" do
    it "creates a new event" do
      login_and_create_user("test","secret")
      visit new_event_path
      lambda do
        fill_in :title, :with => "Rspec Title"
        click_button "Create Event"
      end.should change(Event, :count).by(1)
    end
  end

  describe "PUT /events" do
    it "edit an event" do
      login_and_create_user("test","secret")
      @event = Event.create!(:title => "Opening")
      visit edit_event_path(@event)
      fill_in :title, :with => "Ending"
      click_button "Update Event"
      Event.find_by_title("Ending").should_not be(nil)
    end
  end
end
