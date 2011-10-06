class EventsController < ApplicationController
  load_and_authorize_resource

  def show
  end

  def index
    respond_to do |f|
      f.html
      f.json {render :json => @events}
    end
  end

  def new
  end

  def create
    if @event.save
      redirect_to events_path
    end
  end

  def edit
  end

  def update
    if @event.update_attributes params[:event]
      redirect_to events_path
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path
  end
end
