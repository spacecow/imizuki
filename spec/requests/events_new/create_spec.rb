require 'spec_helper'

describe 'Events, new' do
  context "admin create" do
    before(:each) do
      login_admin
      visit new_event_path
      fill_in 'Title', with:'Opening'
      fill_in 'Content', with:'Finally opening day!'
      fill_in 'Start Date', with:'2012-03-22'
      fill_in 'Start Time', with:'18:00'
      fill_in 'End Date', with:'2012-03-23'
      fill_in 'End Time', with:'22:00'
    end

    context "adds an event to the database" do
      it do
        lambda{ click_button 'Create Event'
        }.should change(Event,:count).by(1)
      end
    end

    context do
      before(:each){ click_button 'Create Event' }
      it "title is set" do
        Event.last.title.should eq 'Opening'
      end

      it "content is set" do
        Event.last.content.should eq 'Finally opening day!'
      end

      it "start date is set" do
        Event.last.start_date.should eq Date.parse('2012-03-22')
      end

      it "start time is set" do
        Event.last.start_time.hour.should eq Time.parse('18:00').hour
      end

      it "end date is set" do
        Event.last.end_date.should eq Date.parse('2012-03-23')
      end

      it "end time is set" do
        Event.last.end_time.hour.should eq Time.parse('22:00').hour
      end

    end

    describe "errors" do
      it "title cannot be blank" do
        fill_in 'Title', with:''
        click_button 'Create Event'
        li(:title).should have_blank_error
      end 
    end
  end
end
