# -*- coding: utf-8 -*-
require 'spec_helper'

describe 'Events, index' do
  context "no user layout without events" do
    before(:each){ visit events_path }

    it "has no title" do
      page.should_not have_title("events")
    end

    it "has no events div" do
      page.should_not have_div(:events)
    end

    it "has no bottom link to a new event" do
      bottom_links.should_not have_link("New Event")
    end
  end #no user layout without events

  context "admin layout without events" do
    before(:each) do
      login_admin
      visit events_path
    end

    it "has a bottom link to a new poem" do
      bottom_links.should have_link("New Event")
    end

    it "links to a new event" do
      bottom_links.click_link "New Event"
      current_path.should eq new_event_path
    end
  end #admin layout without events

  context "admin layout with events" do
    before(:each) do
      login_admin
      @event = Factory(:event)
      visit events_path
    end
    
    it "event has an action div" do
      div(:event,0).should have_div(:actions)
    end 

    it "action div has an edit function" do
      div(:event,0).should have_link('Edit')
    end

    it "links to the edit page" do
      div(:event,0).click_link('Edit')
      current_path.should eq edit_event_path(@event)
    end

    it "action div has an delete function" do
      div(:event,0).should have_link('Del')
    end

    context "deletes an event" do
      it "removes it from the database" do
        lambda{ div(:event,0).click_link('Del')
        }.should change(Event,:count).by(-1)
      end

      it "redirects to the events page" do
        div(:event,0).click_link('Del')
        current_path.should eq events_path
      end

      it "notifies with a flahs message" do
        div(:event,0).click_link('Del')
        page.should have_notice("Successfully deleted Event.")
      end
    end
  end

  context "no user layout with events, without pictures" do
    before(:each) do
      Factory(:event,title:'Opening',start_date:Date.parse('2012-3-20'),content:"The opening of the homepage!")
      visit events_path
    end

    it "the title is a link"
    it "the event title redirects to that event's show page"

    it "has an events div" do
      page.should have_div(:events)
    end

    it "has the number of class event as events" do
      div(:events).divs_no(:event).should be(1)
    end

    it "event has a title" do
      div(:event,0).div(:title).should have_content('Opening')
    end

    it "the contents in the event are centered" do
      div(:event,0).divs_no(:center).should be(3)
    end

    it "has a date div" do
      div(:event,0).should have_div(:date)
    end

    it "date is displayed" do 
      div(:event,0).div(:date).should have_content("3月20日")
    end

    it "has a content div" do
      div(:event,0).should have_div(:content)
    end

    it "content is displayed" do
      div(:event,0).div(:content).should have_content("The opening of the homepage!")
    end

    it "has no thumbs div" do
      div(:event,0).should_not have_div(:thumbs)
    end

    it "action div has no edit function" do
      div(:event,0).should_not have_link('Edit')
    end

    it "action div has no delete function" do
      div(:event,0).should_not have_link('Del')
    end
  end #no user layout with events, without pictures

  context "no user layout with events, with pictures" do
    before(:each) do
      event = Factory(:event)
      Factory(:picture, image:File.open("spec/rails.png"), event_id:event.id)
      visit events_path
    end

    it "the contents in the event is centered" do
      div(:event,0).divs_no(:center).should be(3)
    end

    it "has a thumbs div" do
      div(:event,0).should have_div(:thumbs)
    end

    it "displays the image" do
      div(:event,0).div(:thumbs).should have_image("Thumb_rails")
    end
  end #no user layout with events, with pictures
end
