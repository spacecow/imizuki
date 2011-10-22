class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    if current_user
      redirect_to welcome_url, :alert => alert(:unauthorized_access) 
    else
      redirect_to login_url, :alert => alert(:unauthorized_access)
    end
  end

  def alert(act); t("alert.#{act}") end
  def ft(s); t("formtastic.labels.#{s.to_s}") end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  private

    def authenticate
      unless current_user || Rails.env.test?
        authenticate_or_request_with_http_basic do |username,password|
          @user = User.authenticate(username,password)
          session[:user_id] = @user.id if @user
        end
      end
    end
end
