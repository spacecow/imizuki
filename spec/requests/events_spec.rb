require 'spec_helper'

describe "Events" do
  describe "GET /events" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get events_path
      response.status.should be(200)
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
