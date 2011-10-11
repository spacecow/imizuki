class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:login], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to root_path
    end
  end

  def delete
    session[:user_id] = nil
    redirect_to root_url
  end
end
