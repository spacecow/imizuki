class PicturesController < ApplicationController
  before_filter :load_pictures, :only => :index
  load_and_authorize_resource

  def show
  end

  def index
  end

  def edit
  end

  def last
    respond_to do |f|
      f.json {render :json => Picture.last}
    end
  end

  private

    def load_pictures
      @pictures = Picture.where(:event_id => params[:event_id]) if params[:event_id]
    end
end
