require 'spec_helper'

describe "Events" do
  describe "GET /event" do
    before(:each) do
      @event = Event.create(:title => "Opening")
    end

    context "pictures" do
      before(:each) do
        @pic = create_pic("rails.png", @event)
        visit event_path(@event) 
      end

      it "should be shown" do 
        page.should have_image("Thumb_rails")
      end

      it "should be linked to" do
        click_link("Thumb_rails")
        page.current_path.should == pictures_path
      end 
    end
  end
end
