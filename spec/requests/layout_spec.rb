require 'spec_helper'

describe 'Layout' do
  context "no user" do
    before(:each){ visit events_path }

    it "site nav has a home link" do
      site_nav.should have_link('Events')
    end
    it "site nav has a home link" do
      site_nav.should have_link('Contact')
    end

    context "links to the root page" do
      before(:each) do
        site_nav.click_link 'Events' 
      end

      it "current path is events path" do
        current_path.should eq events_path
      end

      it "selected menu is events" do
        li(:selected,0).should have_content('Events')
      end
    end

    context "links to the contact page" do
      before(:each) do
        site_nav.click_link 'Contact' 
      end

      it "current path is contact path" do
        current_path.should eq contact_path
      end

      it "selected menu is contact" do
        li(:selected,0).should have_content('Contact')
      end
    end
  end
end
