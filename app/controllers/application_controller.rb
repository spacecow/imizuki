class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    #http_basic_authenticate_with :name => "frodo", :password => "thering"

    #render :file => "public/404.html", :status => :unauthorized
    #if current_user
    #  redirect_to welcome_url, :alert => alert(:unauthorized_access) 
    #else
    #  redirect_to login_url, :alert => alert(:unauthorized_access)
    #end
  end

  def alert(act); t("alert.#{act}") end
  def ft(s); t("formtastic.labels.#{s.to_s}") end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
