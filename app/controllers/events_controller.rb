class EventsController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def new
  end

  def create
    if @event.save
      redirect_to events_path
    end
  end
end
