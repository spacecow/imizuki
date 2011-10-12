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
      session[:user_id] = @user.id
      redirect_to root_path
    end
  end

  private

    def authenticate
      authenticate_or_request_with_http_basic do |username,password|
        @user = User.authenticate(username,password)
      end
    end
end
