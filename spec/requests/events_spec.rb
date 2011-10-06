require 'spec_helper'

describe "Events" do
  describe "GET /events" do
    before(:each) do
      @event = Event.create!(:title => "Opening")
      visit events_path
    end

    it "list events" do
      page.should have_content("Opening")
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

    it "show an event" do
      click_link "Opening"
    end
  end

  describe "POST /events" do
    it "creates a new event" do
      visit new_event_path
      lambda do
        fill_in :title, :with => "Rspec Title"
        click_button "Create Event"
      end.should change(Event, :count).by(1)
    end
  end

  describe "PUT /events" do
    before(:each) do
      @event = Event.create!(:title => "Opening")
      visit edit_event_path(@event)
    end

    it "edits an event" do
      fill_in :title, :with => "Ending"
      click_button "Update Event"
      Event.find_by_title("Ending").should_not be(nil)
    end
  end
end
