require 'spec_helper'

describe "Pictures" do
  describe "PUT /event" do
    before(:each) do
      @event = Event.create(:title => "Opening", :main_picture_no => 0)
      @pic = create_pic("rails.png", @event)
      login_and_create_user("test","secret")
    end

    context "a main picture" do
      before(:each) do
        visit edit_picture_path(@pic)
      end

      it "should be choosen as main picture" do
        find_field("Main Picture").should be_checked
      end
    end

    context "a non-main picture" do
      before(:each) do
        @pic2 = create_pic("rails.png", @event)
        visit edit_picture_path(@pic2)
      end

      it "should not be choosen as main picture" do
        find_field("Main Picture").should_not be_checked
      end

      it "select new main picture" do
        choose "Main Picture"
        click_button "Update Picture"
        Event.last.main_picture_no.should be(1)
      end
    end
  end
end
