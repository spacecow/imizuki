class SessionsController < ApplicationController
  before_filter :authenticate, :only => :iphone

  def new
  end

  def create
    user = User.authenticate(params[:login],params[:password])
    if user
      session_userid(user.id)
      flash[:notice] = notify(:logged_in)
      if session_original_url
        url = session_original_url
        session_original_url(nil)
        redirect_to url and return
      end
      redirect_to events_url
    else
      flash[:alert] = alertify(:invalid_login_or_password)
      render :new
    end
  end

  def delete
    session_userid(nil)
    redirect_to root_url, :notice => notify(:logged_out)
  end

  def iphone
    if @user
      redirect_to root_url
    end
  end
end
