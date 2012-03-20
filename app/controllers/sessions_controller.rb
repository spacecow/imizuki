class SessionsController < ApplicationController
  before_filter :authenticate, :only => :iphone

  def new
  end

  def create
    user = User.authenticate(params[:login],params[:password])
    if user
      session_userid(user.id)
      p session_original_url
      if session_original_url
        url = session_original_url
        session_original_url(nil)
        redirect_to url and return
      end
      redirect_to root_url
    else
      flash[:alert] = alert(:invalid_login_or_password)
      render :new
    end
  end

  def delete
    session_userid(nil)
    redirect_to root_url
  end

  def iphone
    if @user
      redirect_to root_path
    end
  end
end
