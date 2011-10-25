require 'spec_helper'

describe "Pictures" do
  describe "GET /pictures" do
    before(:each) do
      @opening = Event.create(:title => "Opening")
      @ending = Event.create(:title => "Ending")
      @pic1 = create_pic("rails.png", @opening)
      @pic2 = create_pic("rails2.png", @ending)
    end

    it "shows all picture" do
      visit pictures_path
      page.should have_image("Thumb_rails")
      page.should have_image("Thumb_rails2")
    end

    it "show all pictures from the opening event" do
      visit pictures_path(:event_id => @opening.id)
      page.should have_image("Thumb_rails")
      page.should_not have_image("Thumb_rails2")
    end

    it "show all pictures from the ending event" do
      visit pictures_path(:event_id => @ending.id)
      page.should_not have_image("Thumb_rails")
      page.should have_image("Thumb_rails2")
    end

    it "picture should be linked to" do
      visit pictures_path
      click_link("Thumb_rails")
      page.current_path.should == picture_path(@pic1)
    end
  end
end
