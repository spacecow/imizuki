require 'spec_helper'

describe 'Layout', focus:true do
  context "no user" do
    describe "root" do
      before(:each){ visit root_path }

      it "site nav container & main container are hidden" do
        divs_no(:hide).should be(2)
      end

      it "has an enter image" do
        div(:contents_container).should have_image("Red_moon_mizuki_portrait")
      end

      it "the image is a link" do
        div(:contents_container).should have_link('Red_moon_mizuki_portrait')
      end

      it "the image links to the events page" do
        div(:contents_container).click_link 'Red_moon_mizuki_portrait'
        current_path.should eq events_path
      end
    end

    describe "site_nav" do
      before(:each){ visit events_path }

      it "site nav container & main container are not hidden" do
        divs_no(:hide).should be(0)
      end

      it "has no enter image" do
        div(:contents_container).should_not have_image("Red_moon_mizuki_portrait")
      end

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
end
