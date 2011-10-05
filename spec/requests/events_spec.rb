require 'spec_helper'

describe "Events" do
  describe "GET /events" do
    before(:each) do
      Event.create!(:title => "Opening")
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
end
