class EventsController < ApplicationController
  load_and_authorize_resource
  #http_basic_authenticate_with :name => current_user.username, :password => "thering", :only => :destroy
  before_filter :authenticate, :only => :destroy

  def show
  end

  def index
    p current_user 
    p "--------------------------"
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

  private

    def authenticate
      authenticate_or_request_with_http_basic do |username,password|
        @user = User.authenticate(username,password)
      end
    end
end
