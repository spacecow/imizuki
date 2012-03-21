require 'spec_helper'

describe 'Layout' do
  context "no user" do
    before(:each){ visit events_path }

    it "site nav has a home link" do
      site_nav.should have_link('Home')
    end

    it "links to the root page" do
      site_nav.click_link 'Home' 
      current_path.should eq events_path
    end
  end
end
