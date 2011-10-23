require 'spec_helper'

describe "Sessions" do
  describe "POST" do
    it "login success" do
      login_and_create_user("test","secret")
      page.current_path.should eq(root_path)
    end

    it "login failure" do
      login("test","secret")
      div("flash_alert").should have_content("Invalid login or password.")
    end

    it "unauthorised access" do
      visit new_event_path
      div("flash_alert").should have_content("Unauthorised access.")
    end
  end
end
