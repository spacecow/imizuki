class EventsController < ApplicationController
  before_filter :set_selected
  before_filter :authenticate, :only => [:create,:update,:destroy]
  load_and_authorize_resource

  def show
  end

  def index
    respond_to do |f|
      f.html
      f.json {render :json => @events.to_json(:include => :pictures)}
    end
  end

  def new
    @event.pictures.build
  end

  def create
    if @event.save
      @event.pictures.reject!{|e| e.image_url.nil?}
      nullify_main_picture_no if @event.pictures.empty?
      redirect_to events_url
    else
      render :new
    end
  end

  def edit
    @event.pictures.build
    @event.main_picture_no = 0 if @event.main_picture_no == -1
  end

  def update
    redirect_to events_path and return if params[:cancel]
    if @event.update_attributes params[:event]
      @event.pictures.reject!{|e| e.image_url.nil?}
      nullify_main_picture_no if @event.pictures.empty?
      redirect_to events_url
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to events_url, :notice => deleted(:event)
  end
  
  private

    def nullify_main_picture_no
      @event.update_attribute(:main_picture_no, -1) 
    end

    def set_selected; @selected = :events end
end
