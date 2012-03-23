require 'spec_helper'

describe "Sessions" do
  describe "login" do
    it "layout" do
      visit root_path
      user_nav.should have_link('Login')
      user_nav.should_not have_link('Logout')
    end

    it "link to login" do
      visit root_path
      click_link 'Login' 
      page.current_path.should eq login_path
    end
  end

  describe "new" do
    context "layout" do
      before(:each){ visit login_path }

      it "has no title" do
        page.should_not have_title('Login')
      end
    end

    context "login user" do
      before(:each) do
        create_user("test")
        login("test")
      end

      it "should take you to the root path" do
        page.current_path.should == events_path
      end

      it "should show a logged-in flash message" do
        page.should have_notice("Logged in.")
      end

      it "should not show the name of he logged in user" do
        page.should_not have_content("Logged in as test.")
      end
    end

    it "redirects to wanted page after login" do
      test = create_user("test")
      visit user_path(test)
      login("test")
      current_path.should eq user_path(test)
    end 

    it "login fails with incorrect information" do
      login("test","wrong")
      page.should have_alert("Invalid login or password.")
    end
  end
end
