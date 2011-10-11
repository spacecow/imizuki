require 'spec_helper'

describe "Sessions" do
  describe "POST" do
    it "login" do
      User.create!(:username => "test", :password => "secret")
      login("test","secret")
      page.current_path.should eq(root_path)
    end
  end
end
