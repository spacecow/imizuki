require 'spec_helper'

describe 'Events, new' do
  context "admin layout" do
    before(:each) do
      login_admin
      visit new_event_path
    end

    it "title field is empty" do
      value('Title').should be_nil
    end

    it "content field is emtpy" do
      value('Content').should be_blank
    end

    it "start date field is emtpy" do
      value('Start Date').should be_nil
    end
    it "start time field is emtpy" do
      value('Start Time').should be_nil
    end

    it "end date field is emtpy" do
      value('End Date').should be_nil
    end
    it "end time field is emtpy" do
      value('End Time').should be_nil
    end
  end
end
