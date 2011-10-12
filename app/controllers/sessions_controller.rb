class SessionsController < ApplicationController
  before_filter :authenticate, :only => :iphone

  def new
  end

  def create
    user = User.authenticate(params[:login],params[:password])
    if user
      session[:user_id] = user.id
      redirect_to root_path
    end
  end

  def delete
    session[:user_id] = nil
    redirect_to root_url
  end

  def iphone
    if @user
      redirect_to root_path
    end
  end
end
