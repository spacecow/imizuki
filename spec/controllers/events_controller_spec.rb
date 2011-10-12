require 'spec_helper'

describe EventsController do
  controller_actions = controller_actions("events")

  before(:each){ @model = Factory(:event) }
 
  describe "a user is not logged in" do
    controller_actions.each do |action,req|
      if %w(show index).include? action
        it "should reach the #{action} page" do
          send("#{req}", "#{action}", :id => @model.id) 
          response.redirect_url.should_not eq(login_url)
        end
      else
        it "should not reach the #{action} page" do
          send("#{req}", "#{action}", :id => @model.id) 
          response.redirect_url.should eq(login_url)
        end
      end
    end
  end
end
