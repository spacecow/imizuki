require 'spec_helper'

describe "Pictures" do
  describe "GET /event" do
    before(:each) do
      @event = Event.create(:title => "Opening")
      @pic = create_pic("rails.png", @event)
    end

    context "not logged in" do
      it "should not be able to edit" do
        visit picture_path(@pic)
        page.should_not have_link("Edit") 
      end

      it "shows the image" do
        visit picture_path(@pic)
        page.should have_image("Rails")
      end

      it "shows the caption" do
        @pic.update_attribute(:caption, "A nice picture")
        visit picture_path(@pic)
        page.should have_content("A nice picture")
      end
    end

    context "logged in" do 
      before(:each) do
        login_admin
        visit picture_path(@pic)
      end

      it "can go to the edit page" do
        click_link "Edit"
        page.current_path.should == edit_picture_path(@pic)
      end
    end
  end
end
