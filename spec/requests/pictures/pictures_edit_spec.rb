require 'spec_helper'

describe "Pictures" do
  describe "PUT /event" do
    before(:each) do
      @event = Event.create(:title => "Opening", :main_picture_no => 0)
      @pic = create_pic("rails.png", @event)
      login_admin
    end

    context "image" do
      before(:each) do
        visit edit_picture_path(@pic)
      end

      it "shows the current one" do
        page.should have_image("Thumb_rails")
      end

      context "change" do
        before(:each) do
          attach_file("Image", File.expand_path("spec/rails2.png"))
        end

        it "update" do
          lambda do
            click_button "Update Picture"
          end.should change(Picture, :count).by(0)
          Picture.last.filename.should == "rails2.png"
        end

        it "cancel" do
          lambda do
            click_button "Cancel"
          end.should change(Picture, :count).by(0)
          Picture.last.filename.should == "rails.png"
        end
      end
    end

    context "caption" do
      before(:each) do
        @pic.update_attributes(:caption => "A nice picture")
        visit edit_picture_path(@pic)
      end

      it "shows the current one" do
        find_field("Caption").value.should == "A nice picture"
      end      

      context "change" do
        before(:each) do
          fill_in("Caption", :with => "A bad picture")
        end

        it "update" do
          lambda do
            click_button "Update Picture"
            Picture.last.caption.should == "A bad picture"
          end.should change(Picture, :count).by(0)
        end

        it "cancel" do
          lambda do
            click_button "Cancel"
            Picture.last.caption.should == "A nice picture"
          end.should change(Picture, :count).by(0)
        end
      end
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

      it "not choosen as main picture" do
        find_field("Main Picture").should_not be_checked
      end

      context "main picture" do 
        before(:each) do
          choose "Main Picture"
        end

        it "select" do
          click_button "Update Picture"
          Event.last.main_picture_no.should be(1)
        end

        it "select but cancel" do
          click_button "Cancel"
          Event.last.main_picture_no.should be(0)
        end
      end
    end
  end
end
